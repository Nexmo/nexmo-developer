class SessionsController < ApplicationController
  def destroy
    sign_out
    cookies.delete :feedback_author_id
    redirect_back(fallback_location: root_path)
  end

  def set_user_locale
    session[:locale] = params[:preferred_locale]
    @path = LocaleRedirector.new(request, params).path
  end
end
