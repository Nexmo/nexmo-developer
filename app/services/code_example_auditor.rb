CODE_EXAMPLE_AUDIOR_MARKDOWN_DIRECTORIES = [
  '_documentation',
  '_api',
]

class CodeExampleAuditor
  def initialize(path = '')
    @path = path
  end

  def examples
    return @examples if @examples

    @examples = []

    documents.each do |document|
      input = File.read(document)

      input.gsub(/```tabbed_examples(.+?)```/m) do |_s|
        config = YAML.safe_load($1)
        if config['source']
          example = examples.detect { |e| e.source == config['source'] }

          unless example
            example = CodeExampleAuditor::Example.new(config)
            examples << example
          end

          example.add_document(document)
        end
      end
    end

    @examples.sort_by! { |example| example.has_spec? ? 0 : 1 }
  end

  def examples_with_manual_tabs
    return @examples_with_manual_tabs if @examples_with_manual_tabs

    @examples_with_manual_tabs = []

    documents.each do |document|
      input = File.read(document)

      input.gsub(/```tabbed_examples(.+?)```/m) do |_s|
        config = YAML.safe_load($1)
        examples_with_manual_tabs << config if config['tabs']
      end
    end

    @examples_with_manual_tabs
  end

  def documents
    @documents ||= (CODE_EXAMPLE_AUDIOR_MARKDOWN_DIRECTORIES.map do |directory|
      Dir.glob("#{Rails.root}/#{@path}/#{directory}/**/*.md")
    end).flatten
  end

  def coverage
    example_coverage = examples.map(&:coverage)
    (example_coverage.sum.fdiv(example_coverage.size) * 100).round(1)
  end

  def self.all_languages
    @all_languages ||= (YAML.load_file("#{Rails.root}/config/code_languages.yml").select do |language, config|
      config['linkable'] != false
    end).keys
  end
end
