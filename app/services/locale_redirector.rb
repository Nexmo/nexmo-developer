class LocaleRedirector
  def initialize(request, params)
    @request = request
    @params  = params
  end

  def path
    "/#{@params[:preferred_locale]}#{current_path}"
  end

  def current_path
    @request
      .referrer
      .sub(@request.protocol, '')
      .sub(@request.host_with_port, '')
      .sub(%r{\/\w{2}\/}, '/')
  end
end
