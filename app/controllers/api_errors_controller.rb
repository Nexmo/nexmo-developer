class ApiErrorsController < ApplicationController
  before_action :error_config
  before_action :validate_subapi

  def index
    @errors_title = 'Generic Errors'
    @errors = generic_errors
    @scoped_errors = @error_config['products'].map do |key, config|
      {
        key: key,
        config: config,
        errors: scoped_errors(key),
      }
    end
  end

  def index_scoped
    @errors_title = @error_config['products'][params[:definition]]['title']
    @hide_rfc7807_header = @error_config['products'][params[:definition]]['hide_rfc7807_header']
    @errors = scoped_errors(params[:definition])
    render 'index'
  end

  def show
    if params[:definition]
      @error = scoped_error(params[:definition], params[:id])
    else
      @error = ApiError.new(@error_config['generic_errors'][params[:id]])
    end
  end

  private

  def generic_errors
    errors = @error_config
    ApiError.parse_config(errors['generic_errors'])
  end

  def scoped_errors(definition)
    # Find all versions of an API and show the details
    definitions = OpenApiConstraint.list.select do |name|
      name == definition || /#{definition}\.v(\d+)/.match(name)
    end

    # Load the errors from all versions
    errors = {}
    definitions.each do |d|
      definition = OpenApiDefinitionResolver.find(d)
      errors = errors.deep_merge(definition.raw['x-errors']) if definition.raw['x-errors']
    end

    ApiError.parse_config(errors)
  end

  def scoped_error(definition, id)
    definition = OpenApiDefinitionResolver.find(definition)
    error = definition.raw['x-errors'][id]
    ApiError.new(error)
  end

  def error_config
    @error_config ||= YAML.load_file("#{Rails.root}/config/api-errors.yml")
  end

  def validate_subapi
    # If there is no subapi specified, everything is fine
    return unless params[:subapi]

    # We used to have some OAS documents that have since been merged in to the top
    # level OAS documents, but we still need to support the old URLs
    # e.g. account/secret-management
    allowed_subapis = {
      'account' => ['secret-management'],
    }

    render_not_found unless allowed_subapis[params[:definition]]&.include? params[:subapi]
  end
end
