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

    @auto_expand_responses = params[:expandResponses]

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
    tags = @definition.raw['tags']
    # For now we only use the first tag in the list as an equivalent for the old x-group functionality
    @groups = @definition.endpoints.group_by do |endpoint|
      next nil unless tags
      endpoint.raw['tags'].first
    end

    # We want to use the order in which the tags are defined in the definition, so iterate over the tags
    # and store the index against the tag name. We'll use this later for sorting
    ordering = {}
    tags&.each_with_index do |tag, index|
      ordering[tag['name'].capitalize] = index
    end

    # Sort by the order in which they're defined in the definition
    @groups = @groups.sort_by do |name, _|
      return 999 if name.nil?
      ordering[name.capitalize] || 999
    end
  end

  def check_redirect
    redirect = Redirector.find(request)
    redirect_to redirect if redirect
  end
end
