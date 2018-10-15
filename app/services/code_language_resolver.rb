class CodeLanguageResolver
  def self.languages
    where_type('languages')
  end

  def self.frameworks
    where_type('platforms')
  end

  def self.terminal_programs
    where_type('terminal_programs')
  end

  def self.data
    where_type('data')
  end

  def self.all
    languages + frameworks + terminal_programs + data
  end

  def self.find(key)
    raise 'Key is missing' unless key
    code_language = all.detect { |lang| lang.key == key }
    raise "Language #{key} does not exist." unless code_language
    code_language
  end

  def self.linkable
    all.select(&:linkable?)
  end

  private_class_method def self.where_type(type)
    language_configuration[type].map do |key, config|
      CodeLanguage.new(config.merge({ key: key, type: type }))
    end
  end

  private_class_method def self.language_configuration
    @language_configuration ||= YAML.load_file("#{Rails.root}/config/code_languages.yml")
  end
end
