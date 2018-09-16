module Feedback
  class FeedbacksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def new; end

    def create
      @feedback = ::Feedback::Feedback.find_by(id: params['feedback_feedback']['id'])
      @feedback ||= ::Feedback::Feedback.new

      return render json: { error: 'Are you a robot? It looks like you failed our reCAPTCHA. Try again.' }, status: :unauthorized unless validate_recapcha

      @feedback.assign_attributes(feedback_params)
      @feedback.ip = request.remote_ip

      @feedback.owner = owner
      set_email
      @feedback.owner.save!
      set_cookies

      return render json: @feedback if @feedback.save
      head 422
    end

    private

    def validate_recapcha
      return true unless ENV['RECAPTCHA_ENABLED']
      return true if session[:user_passed_invisible_captcha]
      return true if @feedback.persisted?

      Recaptcha.with_configuration({ site_key: ENV['RECAPTCHA_INVISIBLE_SITE_KEY'], secret_key: ENV['RECAPTCHA_INVISIBLE_SECRET_KEY'] }) do
        if verify_recaptcha
          session[:user_passed_invisible_captcha] = true
          return true
        end
        return false
      end
    end

    def set_cookies
      return unless @feedback.owner.class == ::Feedback::Author
      cookies[:feedback_author_id] = {
        value: @feedback.owner.id,
        expires: 20.years.from_now,
      }
    end

    def feedback_params
      params.require(:feedback_feedback).permit(
        :sentiment,
        :comment,
        :source,
        :code_language,
        :code_language_set_by_url,
        :code_language_selected_whilst_on_page
      )
    end

    def should_use_cookied_author?(author)
      # Always use the cookied author if cookies[:feedback_author_id] is present
      # but the author is not known by email
      return true if author.email.nil?

      # Always used the cookied author if present but no email has been provided
      # for this request
      return true if params['feedback_feedback']['email'].nil?

      # If the cookied author is known by email, only use it if it matches the
      # email sent in the parameters
      return true if author.email == params['feedback_feedback']['email']

      # Otherwise let's continue to try and lookup the author by email or create
      # a new author if one can not be foundd.
      false
    end

    def owner
      return current_user if current_user

      if cookies[:feedback_author_id]
        author = ::Feedback::Author.find_by(id: cookies[:feedback_author_id])
        return author if author && should_use_cookied_author?(author)
      end

      ::Feedback::Author.find_by(email: params['feedback_feedback']['email']) ||
        ::Feedback::Author.new
    end

    def set_email
      return if @feedback.owner.class == User
      return if params['feedback_feedback']['email'].blank?
      @feedback.owner.email = params['feedback_feedback']['email']
    end
  end
end
