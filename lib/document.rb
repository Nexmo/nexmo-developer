class Document
  attr_accessor :path, :type, :origin, :base_url_path

  def initialize(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def read
    File.read(path)
  end

  def self.all
    document_types = YAML.load_file('config/documents.yml')
    documents = []

    document_types.each do |type, config|
      Dir.glob(config['documents']).each do |document_path|
        documents << Document.new({
          path: Pathname.new(document_path),
          type: type,
          origin: config['origin'],
          base_url_path: config['base_url_path'],
        })
      end
    end

    documents
  end
end
