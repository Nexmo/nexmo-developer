class CareersController < ApplicationController
  def show
    @career = Career.visible_to(current_user).friendly.find(params[:id])

    not_found unless @career
  end
end
