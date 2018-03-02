class SessionsController < ApplicationController
  skip_before_action :authenticate_oauth_user, only: [:omniauth]
  
  def destroy
    sign_out
    cookies.delete :feedback_author_id
    redirect_back(fallback_location: root_path)
  end

  def omniauth
    details = request.env["omniauth.auth"]
    oauth_user = OauthUser.find_by(provider: details['provider'], uid: details['uid'])

    if oauth_user
      oauth_user.update_attribute(:details, details.to_json)
    else
      oauth_user = OauthUser.create!({
        provider: details['provider'],
        uid: details['uid'],
        details: details.to_json
      })
    end

    session[:oauth_user] = oauth_user.id

    redirect_to root_url
  end
end
