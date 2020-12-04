class LocaleRedirector
  def initialize(request, params)
    @request = request
    @params  = params
  end

  def path
    if add_locale?
      "/#{@params[:preferred_locale]}#{current_path}"
    else
      current_path
    end
  end

  def current_path
    @request
      .referrer
      .sub(@request.protocol, '')
      .sub(@request.host_with_port, '')
      .sub(%r{/\w{2}/}, '/')
      .gsub(/\?.*/, '')
  end

  def add_locale?
    @params[:preferred_locale] != I18n.default_locale.to_s &&
      (DocumentationConstraint.product_with_parent_list.any? { |path| current_path.include?(path) } ||
       ['tutorials', 'use-cases'].any? { |path| current_path.include?(path) })
  end
end
