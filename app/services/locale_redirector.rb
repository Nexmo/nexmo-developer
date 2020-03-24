class LocaleRedirector
  def initialize(request, params)
    @request = request
    @params  = params
  end

  def path
    if skip_locale?
      current_path
    else
      "/#{@params[:preferred_locale]}#{current_path}"
    end
  end

  def current_path
    @request
      .referrer
      .sub(@request.protocol, '')
      .sub(@request.host_with_port, '')
      .sub(%r{\/\w{2}\/}, '/')
  end

  def skip_locale?
    @params[:preferred_locale] == I18n.default_locale.to_s ||
      ['tutorials', 'use-cases'].any? { |path| current_path.include?(path) } ||
      current_path == '/'
  end
end
