class Tutorial::FileLoader
  attr_reader :root, :code_language, :doc_name, :format

  def initialize(root:, code_language:, doc_name:, format: 'yml')
    @root          = root
    @code_language = code_language
    @doc_name      = doc_name
    @format        = format
  end

  def path
    @path ||= DocFinder.find(
      root: root,
      document: doc_name,
      language: I18n.locale,
      code_language: code_language,
      format: format
    )
  end

  def content
    @content ||= File.read(path)
  end

  def yaml
    @yaml ||= YAML.safe_load(content)
  end
end
