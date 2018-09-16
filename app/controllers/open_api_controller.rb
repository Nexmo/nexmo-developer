class OpenApiController < ApplicationController
  before_action :check_redirect
  before_action :set_definition
  before_action :set_navigation

  def show
    if File.file? "_open_api/initialization/#{@definition_name}.md"
      definition_initialization = File.read("_open_api/initialization/#{@definition_name}.md")
      @definition_initialization_content = MarkdownPipeline.new.call(File.read("_open_api/initialization/#{@definition_name}.md"))
      @definition_initialization_config = YAML.safe_load(definition_initialization)
    end

    if File.file? "_open_api/errors/#{@definition_name}.md"
      @definition_errors = File.read("_open_api/errors/#{@definition_name}.md")
      @definition_errors_content = MarkdownPipeline.new.call(File.read("_open_api/errors/#{@definition_name}.md"))
    end

    @definition = OpenApiDefinitionResolver.find(@definition_name)

    respond_to do |format|
      format.any(:json, :yaml) { send_file(@definition.path) }
      format.html do
        set_groups
        render layout: 'page-full'
      end
    end
  end

  private

  def set_navigation
    @navigation = :api
  end

  def set_definition
    @definition_name = params[:definition]
  end

  def set_groups
    @groups = @definition.endpoints.group_by { |endpoint| endpoint.raw['x-group'] }
    @groups = @groups.sort_by do |name, _|
      next 999 if name.nil?
      @definition.raw['x-groups'][name]['order'] || 999
    end
  end

  def check_redirect
    redirect = Redirector.find(request)
    redirect_to redirect if redirect
  end
end
