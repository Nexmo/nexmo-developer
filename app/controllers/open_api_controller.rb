class OpenApiController < ApplicationController
  before_action :set_specification

  def show
    if File.file? "_open_api/#{@specification_name}.json"
      @specification_path = "_open_api/#{@specification_name}.json"
    else
      @specification_path = "_open_api/#{@specification_name}.yml"
    end

    @specification = OpenApiParser::Specification.resolve(@specification_path)
    render layout: 'page-full'
  end

  private

  def set_specification
    @specification_name = params[:specification]
  end
end
