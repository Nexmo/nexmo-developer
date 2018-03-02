class ApplicationController < ActionController::Base
  NotAuthorized = Class.new(StandardError)

  rescue_from Errno::ENOENT, with: :no_document
  rescue_from Errno::ENOENT, with: :no_document
  rescue_from NotAuthorized, with: :unauthorized
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD'], if: :requires_authentication?

  force_ssl if: :ssl_configured?
  before_action :set_show_feedback
  before_action :set_notices
  before_action :set_code_language
  before_action :set_canonical_url
  before_action :set_feedback_author
  before_action :authenticate_oauth_user

  def authenticate_oauth_user
    raise NotAuthorized unless oauth_user_has_access_to_resource?
  end

  def protected_resource?
    true
  end

  def oauth_user_has_access_to_resource?
    return true unless protected_resource?
    return false unless session[:oauth_user]
    true
  end

  def not_found
    redirect = Redirector.find(request)
    if redirect
      redirect_to redirect
    else
      NotFoundNotifier.notify(request)
      render 'static/404', status: :not_found, formats: [:html]
    end
  end

  def authenticate_admin!
    return redirect_to new_user_session_path unless user_signed_in?
    redirect_to root_path unless current_user.admin?
  end

  private

  def requires_authentication?
    ENV['USERNAME'] && ENV['PASSWORD']
  end

  def unauthorized
    render 'static/401', status: :unauthorized, formats: [:html], layout: 'page'
  end

  def no_document
    not_found
  end

  def set_show_feedback
    @show_feedback = true
  end

  def set_code_language
    @code_language = request.params[:code_language]
  end

  def ssl_configured?
    return false if Rails.env.development?
    return false if Rails.env.test?
    return true
  end

  def set_notices
    @notices ||= YAML.load_file("#{Rails.root}/config/notices.yml")
  end

  def set_canonical_url
    @show_canonical_meta = params[:code_language].present?
    @canonical_url = request.path.chomp("/#{params[:code_language]}")
    @canonical_url.prepend(request.base_url)
  end

  def set_feedback_author
    return unless cookies[:feedback_author_id]
    @feedback_author = Feedback::Author.select(:email).find_by_id(cookies[:feedback_author_id])
  end
end
