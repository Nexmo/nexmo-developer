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

    # We need the base name to append our versions to later
    @definition_base_name = @definition_name.gsub(/\.v\d+/, '')
    m = /\.v(\d+)/.match(@definition_name)
    @current_version = m.nil? ? '1' : m[1]

    # Do we have multiple versions available for this API?
    @available_versions = OpenApiConstraint.find_all_versions(@definition_base_name)

    # Add in anything in the old /_api folder
    if File.exist?("#{Rails.root}/_api/#{@definition_base_name}.md")
      @available_versions.push({ 'version' => '1', 'name' => @definition_base_name })
    end

    @available_versions.sort_by! { |v| v['version'] }

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
      endpoint.raw['tags']&.first
    end

    # We want to use the order in which the tags are defined in the definition, so iterate over the tags
    # and store the index against the tag name. We'll use this later for sorting
    ordering = {}
    tags&.each_with_index do |tag, index|
      ordering[tag['name'].capitalize] = index
    end

    # Sort by the order in which they're defined in the definition
    @groups = @groups.sort_by do |name, _|
      next -1 if name.nil?
      ordering[name.capitalize] || 999
    end
  end

  def check_redirect
    redirect = Redirector.find(request)
    redirect_to redirect if redirect
  end
end

# We should fix this in OasParser properly rather than monkeypatching at some point
module OasParser
  class Path
    def servers
      raw['servers']
    end
  end

  class Parser
    def self.resolve(path)
      filename = path.split('#/')[0]
      content = YAML.load_file(filename)
      Parser.new(filename, content).resolve
    end

    def expand_refs(fragment)
      if fragment.is_a?(Hash) && fragment.key?('$ref')
        ref = fragment['$ref']

        re = '\A#/'
        if /#{re}/.match?(ref)
          expand_pointer(ref)
        else
          expand_file(ref)
        end
      else
        fragment
      end
    end

    def expand_file(ref)
      relative_path = ref.split(':').last
      absolute_path = File.expand_path(File.join('..', relative_path), @path)

      file = Parser.resolve(absolute_path)

      pointer = ref.split('#/')[1]
      if pointer
        pointer = '#/' + pointer
        return Parser.new(absolute_path, file).expand_pointer(pointer)
      end

      file
    end

    def expand_pointer(ref)
      pointer = OasParser::Pointer.new(ref)
      fragment = pointer.resolve(@content)

      expand_refs(fragment)
    end
  end

  class Endpoint
    def oauth?
      return false unless security

      security_schemes.each do |security_schema|
        return true if security_schema['bearerFormat'] == 'OAuth'
      end

      false
    end
  end
end
