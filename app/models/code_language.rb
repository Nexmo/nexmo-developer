class CodeLanguage
  include ActiveModel::Model
  attr_accessor :key, :label, :type, :dependencies, :unindent, :icon, :run_command
  attr_writer :weight, :linkable, :languages, :lexer

  def weight
    @weight || 999
  end

  def linkable?
    return true if @linkable.nil?

    @linkable
  end

  def lexer
    return Rouge::Lexers::PHP.new({ start_inline: true }) if @lexer == 'php'

    Rouge::Lexer.find(@lexer) || Rouge::Lexer.find('text')
  end

  def languages
    @languages ||= []
    @languages.map do |language|
      self.class.find(language)
    end
  end

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

  def self.exists?(key)
    all.detect { |lang| lang.key == key }
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

  def self.route_constraint
    { code_language: Regexp.new(linkable.map(&:key).compact.join('|')) }
  end

  private_class_method def self.where_type(type)
    config[type].map do |key, attributes|
      new(attributes.merge({ key: key, type: type }))
    end
  end

  private_class_method def self.config
    @config ||= YAML.load_file("#{Rails.root}/config/code_languages.yml")
  end
end
