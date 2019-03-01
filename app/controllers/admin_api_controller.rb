class AdminApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def authenticated?
    bearer_token = request.headers['Authorization']&.match(/^Bearer /)&.post_match
    return false unless bearer_token
    User.where(admin: true, nexmo_developer_api_secret: bearer_token).exists?
  end

  def authenticate
    return true if authenticated?
    render plain: 'Unauthorized', status: :unauthorized
    false
  end
end
