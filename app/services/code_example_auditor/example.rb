class CodeExampleAuditor::Example
  attr_reader :documents

  def initialize(config)
    @config = config
    @documents = []
  end

  def source
    @config['source']
  end

  def github_path
    "https://github.com/Nexmo/nexmo-developer/tree/master/#{source}"
  end

  def add_document(document)
    @documents << document
    @documents.uniq!
  end

  def missing_languages
    CodeExampleAuditor.all_languages - languages
  end

  def languages
    Dir.glob("#{source}/*").map { |s| File.basename(s).downcase }
  end

  def title
    return 'No title' unless spec
    spec['title']
  end

  def description
    return 'No description' unless spec
    spec['description']
  end

  def has_spec?
    File.exist? "#{source}/.spec"
  end

  def spec
    return false unless has_spec?
    @spec ||= YAML.load_file("#{source}/.spec")
  end

  def coverage
    languages.count.to_f / CodeExampleAuditor.all_languages.count.to_f
  end

  def documents_relative
    @documents.map do |document|
      document.sub!(Rails.root.to_s, '')
      document.sub!('//', '/')
    end
  end

  def html
    input = <<~HEREDOC
      ```tabbed_examples
      #{@config.to_yaml.sub('---', '')}
      ```
    HEREDOC

    input = TabbedExamplesFilter.new.call(input)
    UnfreezeFilter.new.call(input)
  end
end
