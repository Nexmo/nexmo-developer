class CareersController < ApplicationController
  def index
    @careers = Greenhouse.careers
  end
end
