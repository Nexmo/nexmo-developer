class SidenavSubitem < SidenavItem
  include Rails.application.routes.url_helpers

  def title
    @title ||= TitleNormalizer.call(@folder)
  end

  def show_link?
    @folder[:is_file?] || @folder[:is_tabbed?]
  end

  def collapsible?
    @options['collapsible'].nil? || @options['collapsible']
  end

  def url
    @url ||= @folder[:external_link] || build_url
  end

  def build_url
    if @folder[:root] == 'config/tutorials'
      url_for(
        tutorial_name: Navigation.new(@folder).path_to_url,
        controller: :tutorial,
        action: :index,
        product: @folder[:product],
        only_path: true
      )
    elsif @folder[:root] == '_use_cases'
      url_for(
        document: Navigation.new(@folder).path_to_url,
        controller: controller,
        action: :show,
        only_path: true
      )
    else
      "/#{Navigation.new(@folder).path_to_url}"
    end
  end

  def controller
    if @folder[:path].starts_with?('_documentation')
      :markdown
    elsif @folder[:path].starts_with?('_use_cases')
      :use_case
    end
  end

  def active?
    if navigation == :tutorials
      active_path.starts_with?(url)
    else
      url == active_path
    end
  end

  def active_path
    @active_path ||= request_path.chomp("/#{code_language}")
  end

  def link_css_class
    active? ? 'Vlt-sidemenu__link_active' : ''
  end
end
