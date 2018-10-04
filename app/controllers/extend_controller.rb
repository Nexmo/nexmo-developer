class ExtendController < ApplicationController
  before_action :set_header

  def index
    document_paths = Dir.glob("#{Rails.root}/_extend/**/*.md")

    @extensions = document_paths.map do |document_path|
      document = File.read(document_path)
      frontmatter = YAML.safe_load(document)
      title = frontmatter['title']
      description = frontmatter['description']
      tags = frontmatter['tags'] || []
      image = frontmatter['image'] || ''
      route = File.basename(document_path, '.*')
      { title: title, description: description, tags: tags, image: image, route: route }
    end

    render layout: 'page'
  end

  def show
    document_path = "#{Rails.root}/_extend/#{params[:title]}.md"

    document = File.read(document_path)
    body = MarkdownPipeline.new.call(document)
    frontmatter = YAML.safe_load(document)
    title = frontmatter['title']
    description = frontmatter['description']
    tags = frontmatter['tags'] || []
    image = frontmatter['image'] || ''
    link = frontmatter['link'] || ''
    @extension = { title: title, body: body, image: image, description: description, tags: tags, link: link }

    render layout: 'page'
  end

  private

  def set_header
    @navigation = :extend
  end
end
