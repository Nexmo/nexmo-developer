class ApiErrorsController < ApplicationController
  def index
    @errors = YAML.load_file("#{Rails.root}/config/api-errors.yml")
  end

  def show
    @error = YAML.load_file("#{Rails.root}/config/api-errors.yml")[params['id']]
  end
end
