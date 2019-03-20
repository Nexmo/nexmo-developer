module AdminApi
  class FeedbackController < AdminApiController
    respond_to :json

    def index
      return unless authenticate

      @feedbacks = Feedback::Feedback.created_between(params[:created_after], params[:created_before])

      render :index
    end
  end
end
