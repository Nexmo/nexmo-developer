class DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_additional_scripts

  def stats
    @feedbacks = Feedback::Feedback

    if product
      @feedbacks = @feedbacks.joins(:resource).where(feedback_resources: { product: product })
    end

    if created_after && created_before
      @feedbacks = @feedbacks.created_between(created_after, created_before)
    elsif created_after
      @feedbacks = @feedbacks.created_after(created_after)
    elsif created_before
      @feedbacks = @feedbacks.created_before(created_before)
    end
  end

  private

  def set_additional_scripts
    @additional_scripts = ['stats']
  end

  def product
    params[:product] if params[:product].present?
  end

  def created_before
    @created_before ||= params[:created_before] if params[:created_before].present?
  end

  def created_after
    @created_after ||= params[:created_after] if params[:created_after].present?
  end
end
