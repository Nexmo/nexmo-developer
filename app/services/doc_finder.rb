class DocFinder
  class MissingDoc < StandardError; end

  EXCLUSIONS = ['.', '..', I18n.default_locale.to_s].freeze

  class << self
    mattr_accessor :paths
    mattr_accessor :dictionary
  end

  # rubocop:disable Metrics/ParameterLists
  def self.find(root:, document:, language: nil, product: nil, code_language: nil, format: 'md', strip_root_and_language: false)
    if strip_root_and_language
      document = strip_root_and_language(root: root, language: "(#{language}|#{I18n.default_locale})", document: document)
    end
    begin
      if code_language.present?
        linkable_code_language(
          root: root,
          language: language,
          product: product,
          document: document,
          code_language: code_language,
          format: format
        )
      else
        non_linkable(
          root: root,
          language: language,
          product: product,
          document: document,
          format: format
        )
      end
    rescue KeyError => e
      raise MissingDoc, e.message
    end
  end

  def self.linkable_code_language(root:, language:, document:, product: nil, code_language: nil, format: nil)
    key = [
      build_key(root: root, product: product, document: "#{document}/#{code_language}", format: format),
      build_key(root: root, product: product, document: document, format: format),
    ].select { |k| dictionary.key?(k) }.first

    available_language = dictionary.fetch(key).fetch(language, I18n.default_locale.to_s)
    build_doc_path(root, key, available_language)
  end

  def self.non_linkable(root:, language:, document:, product: nil, format: nil)
    key = build_key(root: root, product: product, document: document, format: format)
    if root.starts_with?('app/views')
      dictionary.fetch(key) && key
    else
      available_language = dictionary.fetch(key).fetch(language.to_s, I18n.default_locale.to_s)
      build_doc_path(root, key, available_language)
    end
  end
  # rubocop:enable Metrics/ParameterLists

  def self.build_key(root:, document:, product: nil, format: nil)
    path = if Pathname.new(document).extname.blank?
             "#{root}/#{product}/#{document}.#{format}"
           else
             "#{root}/#{product}/#{document}"
           end
    path.gsub(%r{\/\/\/|\/\/}, '/')
  end

  def self.build_doc_path(root, doc, language)
    doc.gsub(root, "#{root}/#{language}")
  end

  def self.configure
    self.paths = []
    self.dictionary = Hash.new { |hash, key| hash[key] = {} }

    yield(self)

    load_english
    load_languages
  end

  def self.load_english
    paths.each do |path|
      if path.starts_with?('app/views')
        Dir["#{path}/**/*.*"].each do |file|
          dictionary[file][I18n.default_locale.to_s] = I18n.default_locale.to_s
        end
      else
        path_with_locale = "#{path}/#{I18n.default_locale}"
        Dir["#{path_with_locale}/**/{*.*,.config.yml}"].each do |file|
          key = "#{path}/#{file.gsub("#{path_with_locale}/", '')}"
          dictionary[key][I18n.default_locale.to_s] = I18n.default_locale.to_s
        end
      end
    end
  end

  def self.load_languages
    paths.each do |path|
      Dir.foreach(path).reject { |d| EXCLUSIONS.include? d }.each do |language|
        Dir.glob("#{path}/#{language}/**/{*.*,.config.yml}").each do |file|
          doc_name = strip_root_and_language(root: path, language: language, document: file)
          key = "#{path}/#{doc_name}"
          dictionary[key][language] = language
        end
      end
    end
  end

  def self.strip_root_and_language(root:, language:, document:)
    document.sub(%r{#{root}\/}, '').sub(%r{#{language}\/}, '')
  end
end
