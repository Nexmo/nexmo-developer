class TutorialsController < ApplicationController
  before_action :set_document
  before_action :set_navigation

  def index
    @product = params['product']

    if @product
      @tutorials = Tutorial.by_product(params['product'])
    else
      @tutorials = Tutorial.all
    end

    @document_title = 'Tutorials'

    render layout: 'page'
  end

  def show
    @document_path = "_tutorials/#{@document}.md"

    # Read document
    document = File.read("#{Rails.root}/#{@document_path}")

    # Parse frontmatter
    @frontmatter = YAML.safe_load(document)
    @document_title = @frontmatter['title']

    @content = MarkdownPipeline.new({ code_language: @code_language }).call(document)

    render layout: 'static'
  end

  private

  def set_document
    @document = params[:document]
  end

  def set_navigation
    @navigation = :tutorials
    @side_navigation_extra_links = {
      'Tutorials' => '/tutorials',
    }
  end
end
