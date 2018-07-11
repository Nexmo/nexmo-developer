class SessionsController < ApplicationController
  def destroy
    sign_out
    cookies.delete :feedback_author_id
    redirect_back(fallback_location: root_path)
  end
end
