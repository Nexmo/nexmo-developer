class ApplicationController < ActionController::Base
  include ApplicationHelper

  rescue_from Errno::ENOENT, with: :not_found
  rescue_from Nexmo::Markdown::DocFinder::MissingDoc, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD'], if: :requires_authentication?

  before_action :set_show_feedback
  before_action :set_notices
  before_action :set_code_language
  before_action :set_feedback_author
  before_action :set_locale

  def not_found
    redirect = Redirector.find(request)
    if redirect
      redirect_to redirect
    else
      NotFoundNotifier.notify(request)
      not_found_search_results if search_enabled?
      render_not_found
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

  def set_show_feedback
    @show_feedback = true
  end

  def set_code_language
    return unless request.params[:code_language]

    @code_language = Nexmo::Markdown::CodeLanguage.find(request.params[:code_language])
  end

  def set_notices
    @notices = YAML.load_file("#{Rails.root}/config/notices.yml")
  end

  def set_feedback_author
    return unless cookies[:feedback_author_id]

    @feedback_author = Feedback::Author.select(:email).find_by(id: cookies[:feedback_author_id])
  end

  def not_found_search_results
    parameters = ALGOLIA_CONFIG.keys.map do |index|
      {
        index_name: index,
        query: request.path.split('/').last.titleize,
        hitsPerPage: 5,
      }
    end

    @results = Algolia.multiple_queries(parameters)
    @results = JSON.parse(@results.to_json, object_class: OpenStruct).results
  end

  def render_not_found
    render 'static/404', status: :not_found, formats: [:html]
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end
end
