class AdminApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def authenticated?
    return false unless bearer_token
    User.where(admin: true, nexmo_developer_api_secret: bearer_token).exists?
  end

  def authenticate
    return true if authenticated?
    render plain: 'Unauthorized', status: :unauthorized
    false
  end

  private

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end
end
