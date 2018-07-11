class OpenApiDefinitionResolver

  def self.find(name)
    path = paths(name).detect do |path|
      break path if File.file? path
    end

    unless path
      if NexmoApiSpecification::Definition.exists?(name)
        path = NexmoApiSpecification::Definition.path(name)
      end
    end

    return resolve(path) if path

    raise "Could not find definition '#{name}'"
  end

  private

  def self.paths(name)
    ['json', 'yaml', 'yml'].map do |format|
      self.path(name, format)
    end
  end

  def self.path(name, format)
    "_open_api/definitions/#{name}.#{format}"
  end

  def self.resolve(path)
    OasParser::Definition.resolve(path)
  end
end
