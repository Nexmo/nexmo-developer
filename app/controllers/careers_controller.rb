class CareersController < ApplicationController
  def show
    if current_user&.admin?
      scope = Career
    else
      scope = Career.published
    end

    @career = scope.friendly.find(params['id'])
    not_found unless @career
  end
end
