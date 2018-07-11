module AdminApi
  class FeedbackController < AdminApiController
    respond_to :json

    def index
      return unless authenticate
      @feedbacks = Feedback::Feedback.all

      if params[:created_after] || params[:created_before]
        if params[:created_after] && params[:created_before]
          @feedbacks = @feedbacks.created_between(params[:created_after], params[:created_before])
        elsif params[:created_after]
          @feedbacks = @feedbacks.created_after(params[:created_after])
        elsif params[:created_before]
          @feedbacks = @feedbacks.created_before(params[:created_before])
        end
      end

      render :index
    end
  end
end
