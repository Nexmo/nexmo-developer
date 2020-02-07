class Tutorial::Metadata
  attr_reader :name, :file_loader
  delegate :path, :yaml, to: :file_loader

  def initialize(name:)
    @name        = name
    @file_loader = load_file!
  end

  def products
    @products ||= yaml['products'] || []
  end

  def title
    @title ||= yaml['title']
  end

  def description
    @description ||= yaml['description']
  end

  def external_link
    @external_link ||= yaml['external_link']
  end

  def available_code_languages
    @available_code_languages ||= begin
      DocFinder
        .code_languages_for_tutorial(path: path.sub('.yml', '/'))
        .map { |file_path| File.basename(Pathname.new(file_path).basename, '.yml') }
    end
  end

  def code_language
    @code_language ||= begin
        available_code_languages
          .min_by { |k| CodeLanguage.languages.map(&:key).index(k) }
      end
  end

  def default_product
    @default_product ||= products.first
  end

  def load_file!
    Tutorial::FileLoader.new(
      root: Tutorial.tutorials_path,
      code_language: nil,
      doc_name: @name
    )
  end
end
