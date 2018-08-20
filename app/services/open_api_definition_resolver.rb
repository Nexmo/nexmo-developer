class OpenApiDefinitionResolver
  def self.find(name)
    path = paths(name).detect do |p|
      break p if File.file? p
    end

    unless path
      if NexmoApiSpecification::Definition.exists?(name)
        path = NexmoApiSpecification::Definition.path(name)
      end
    end

    return resolve(path) if path

    raise "Could not find definition '#{name}'"
  end

  private_class_method def self.paths(name)
    ['json', 'yaml', 'yml'].map do |format|
      path(name, format)
    end
  end

  private_class_method def self.path(name, format)
    "_open_api/definitions/#{name}.#{format}"
  end

  private_class_method def self.resolve(path)
    OasParser::Definition.resolve(path)
  end
end
