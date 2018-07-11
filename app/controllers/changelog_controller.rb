class ChangelogController < ApplicationController
  def index
    document_paths = Dir.glob("#{Rails.root}/_changelog/**/*.md").sort

    @versions = document_paths.map do |document_path|
      document = File.read(document_path)
      body = MarkdownPipeline.new.call(document)
      frontmatter = YAML.safe_load(document)
      title = frontmatter['title']
      version = frontmatter['version']
      date = Date.parse(frontmatter['date'])

      { title: title, version: version, body: body, date: date }
    end

    render layout: 'page'
  end

  def show
    document_path = "#{Rails.root}/_changelog/#{params[:version]}.md"

    document = File.read(document_path)
    body = MarkdownPipeline.new.call(document)
    frontmatter = YAML.safe_load(document)
    title = frontmatter['title']
    version = frontmatter['version']
    date = Date.parse(frontmatter['date'])

    @version = { title: title, version: version, body: body, date: date }

    render layout: 'page'
  end
end
