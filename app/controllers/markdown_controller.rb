class MarkdownController < ApplicationController
  before_action :set_navigation
  before_action :set_product
  before_action :set_tracking_cookie
  before_action :check_redirects, only: :show
  before_action :canonical_redirect, only: :show

  def show
    if path_is_folder?
      @frontmatter, @content = content_from_folder
    else
      @document_path = document.path
      @frontmatter, @content = content_from_file
      set_canonical_url
    end

    @sidenav = Sidenav.new(
      namespace: params[:namespace],
      locale: params[:locale],
      request_path: request.path,
      navigation: @navigation,
      code_language: params[:code_language],
      product: @product
    )

    if !Rails.env.development? && @frontmatter['wip']
      @show_feedback = false
      render 'wip', layout: 'documentation'
    else
      render layout: 'documentation'
    end
  end

  def api
    redirect = Redirector.find(request)
    if redirect
      redirect_to redirect
    else
      render_not_found
    end
  end

  private

  def set_navigation
    @navigation = :documentation
  end

  def set_product
    @product = params[:product]
  end

  def set_tracking_cookie
    helpers.dashboard_cookie(params[:product])
  end

  def document
    @document ||= Nexmo::Markdown::DocFinder.find(
      root: root_folder,
      document: params[:document],
      language: params[:locale],
      product: params[:product],
      code_language: params[:code_language]
    )
  end

  def root_folder
    if params[:namespace].present?
      "app/views/#{params[:namespace]}"
    else
      "#{Rails.configuration.docs_base_path}/_documentation"
    end
  end

  def path_is_folder?
    folder_config_path
  rescue Nexmo::Markdown::DocFinder::MissingDoc
    false
  end

  def folder_config_path
    @folder_config_path ||= Nexmo::Markdown::DocFinder.find(
      root: root_folder,
      document: "#{params[:document]}/.config.yml",
      language: params[:locale],
      product: params[:product],
      code_language: params[:code_language]
    ).path
  end

  def content_from_folder
    frontmatter = YAML.safe_load(File.read(folder_config_path))
    path = folder_config_path.chomp('/.config.yml')

    @document_title = frontmatter['meta_title'] || frontmatter['title']

    content = Nexmo::Markdown::Renderer.new({
      code_language: @code_language,
      current_user: current_user,
    }).call(<<~HEREDOC
      <h1>#{@document_title}</h1>

      ```tabbed_folder
      source: #{path}
      ```
    HEREDOC
           )

    [frontmatter, content]
  end

  def content_from_file
    content = File.read(document.path)
    frontmatter = YAML.safe_load(content)

    raise Errno::ENOENT if frontmatter['redirect']

    content = Nexmo::Markdown::Renderer.new({
      code_language: @code_language,
      current_user: current_user,
      locale: params[:locale],
    }).call(content)

    [frontmatter, content]
  end

  def set_canonical_url
    if params[:namespace] || !params[:locale] || document.available_languages.include?(params[:locale])
      @canonical_url = canonical_url
    else
      @canonical_url = "#{canonical_base}#{canonical_path.sub("#{params[:locale]}/", '')}"
    end
  end

  def check_redirects
    redirect = Redirector.find(request)
    return redirect_to redirect if redirect
  end

  def canonical_redirect
    # TODO: change this to use the locale from the domain
    # once we add support for that.

    return if params[:namespace]
    return if params[:locale].nil? && session[:locale].nil?
    return if params[:locale] && params[:locale] != I18n.default_locale.to_s

    if params[:locale]
      redirect_to url_for(
        controller: :markdown,
        action: :show,
        only_path: true,
        locale: nil,
        document: params[:document],
        product: params[:product]
      )
    elsif session[:locale] && session[:locale] != I18n.default_locale.to_s
      redirect_to "/#{session[:locale]}/#{params[:product]}/#{params[:document]}"
    end
  end
end
