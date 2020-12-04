class SlackController < ApplicationController
  before_action :set_navigation
  before_action :set_email, only: [:invite]
  before_action :validate_recapcha, only: [:invite]
  before_action :validate_email, only: [:invite]

  def join; end

  def invite
    response = RestClient.post "https://#{ENV['SLACK_SUBDOMAIN']}.slack.com/api/users.admin.invite", {
      token: ENV['SLACK_TOKEN'],
      email: @email,
    }

    response = JSON.parse(response)

    if response['ok']
      @invitation_sent_successfully = true
      @notice = "An invitation has been sent to #{@email}"
    else
      case response['error']
      when 'already_invited'
        @notice = "It looks like you've already been sent an invitation."
      when 'already_in_team'
        @notice = 'You are already a member of this Slack'
      else
        Bugsnag.notify('Slack Error') do |notification|
          notification.add_tab(:slack, { response: response })
        end
        @notice = 'Something went wrong. Please try again later.'
      end
    end

    render 'join'
  end

  private

  def set_navigation
    @navigation = :community
  end

  def set_email
    @email = params[:email]
  end

  def validate_recapcha
    return unless ENV['RECAPTCHA_ENABLED']
    return if verify_recaptcha

    @notice = 'Are you a robot? It looks like you failed our reCAPTCHA. Try again.'
    render 'join'
  end

  def validate_email
    return if EmailValidator.valid?(@email)

    @notice = 'Invalid email, try again.'
    render 'join'
  end
end
