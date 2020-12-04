class ApplicationController < ActionController::Base
  include ApplicationHelper

  helper_method :page_title

  rescue_from Errno::ENOENT, with: :not_found
  rescue_from Nexmo::Markdown::DocFinder::MissingDoc, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD'], if: :requires_authentication?

  before_action :set_notices
  before_action :set_code_language
  before_action :set_feedback_author
  before_action :set_locale

  def not_found(exception = nil)
    redirect = Redirector.find(request)
    if redirect
      redirect_to redirect
    else
      NotFoundNotifier.notify(request, exception)
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

  def set_code_language
    return unless request.params[:code_language]

    @code_language = Nexmo::Markdown::CodeLanguage.find(request.params[:code_language])
  end

  # rubocop:disable Naming/MemoizedInstanceVariableName
  def set_notices
    @notices ||= LoadConfig.load_file('config/notices.yml') || {}
  end
  # rubocop:enable Naming/MemoizedInstanceVariableName

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
    I18n.locale = params[:locale] || session[:locale] || locale_from_domain
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  def locale_from_domain
    if Rails.env.production?
      request.host == 'developer.nexmocn.com' ? 'cn' : 'en'
    else
      I18n.default_locale
    end
  end

  def page_title
    @page_title ||= PageTitle.new(@product, @document_title).title
  end
end
