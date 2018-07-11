module OpenApi
  class Callback
    attr_accessor :name, :config

    def initialize(name, config)
      @name = name
      @config = config
    end

    def summary
      default['summary']
    end

    def description
      default['description']
    end

    def schema
      default['requestBody']['content'].values[0]['schema']
    end

    def parameters
      properties = schema['properties']
      properties.map { |key, value| { 'name' => key }.merge(value) }
    end

    def default
      config.values[0].values[0]
    end
  end
end
