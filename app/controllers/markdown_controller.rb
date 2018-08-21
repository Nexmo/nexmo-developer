class MarkdownController < ApplicationController
  before_action :set_navigation, except: [:preview]
  before_action :set_namespace

  skip_before_action :verify_authenticity_token, only: [:preview]

  def show
    @frontmatter = YAML.safe_load(document)

    raise Errno::ENOENT if @frontmatter['redirect']

    @document_title = @frontmatter['title']

    @content = MarkdownPipeline.new({
      code_language: @code_language,
      current_user: current_user,
    }).call(document)

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
      render 'static/404', status: :not_found, formats: [:html]
    end
  end

  def preview
    return render 'preview', layout: 'page-full' if request.method == 'GET'

    content = MarkdownPipeline.new.call(params['markdown'])

    render json: { html: content }
  end

  private

  def set_navigation
    @navigation = :documentation
  end

  def set_namespace
    if params[:namespace].present?
      @namespace_path = "app/views/#{params[:namespace]}"
      @namespace_root = 'app/views'
      @sidenav_root = "app/views/#{params[:namespace]}"
    else
      @namespace_path = "_documentation/#{params[:product]}"
      @namespace_root = '_documentation'
      @sidenav_root = "#{Rails.root}/_documentation"
    end
  end

  def document
    @document_path = "#{@namespace_path}/#{params[:document]}.md"
    @document = File.read("#{Rails.root}/#{@document_path}")
  end
end
