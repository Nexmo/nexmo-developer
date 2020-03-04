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
        only_path: true,
        locale: locale
      }
      params.merge!(locale: I18n.locale) if enforce_locale?
      url_for(params)
      )
    elsif @folder[:root] == "#{Rails.configuration.docs_base_path}/_use_cases"
      url_for(
        document: Navigation.new(@folder).path_to_url,
        controller: controller,
        action: :show,
        only_path: true,
        locale: locale
      )
    else
      url_for(
        controller: :markdown,
        action: :show,
        document: Navigation.new(@folder).path_to_url,
        only_path: true,
        locale: locale
      )
    end
  end

  def controller
    if @folder[:path].starts_with?("#{Rails.configuration.docs_base_path}/_documentation")
      :markdown
    elsif @folder[:path].starts_with?("#{Rails.configuration.docs_base_path}/_use_cases")
      :use_case
    end
  end
end
