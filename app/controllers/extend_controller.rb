class ExtendController < ApplicationController
  def index  
    document_paths = Dir.glob("#{Rails.root}/_extend/**/*.md")

    @extensions = document_paths.map do |document_path|
      document = File.read(document_path)
      body = MarkdownPipeline.new.call(document)
      frontmatter = YAML.safe_load(document)
      title = frontmatter['title']
      description = frontmatter['description']
      tags = frontmatter['tags'] || []
      languages = frontmatter['languages'] || []
      image = frontmatter['image'] || ''
      { title: title, description: description, tags: tags, languages: languages, image: image }
    end

      render layout: 'page'
    end
  
    def show
      render layout: 'page'
    end
  end
  