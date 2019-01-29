class TutorialsController < ApplicationController
  before_action :set_document
  before_action :set_navigation

  def index
    @product = params['product']
    @language = params['code_language']

    @tutorials = Tutorial.all

    @tutorials = Tutorial.by_product(@product, @tutorials) if @product
    @tutorials = Tutorial.by_language(@language, @tutorials) if @language

    @document_title = 'Tutorials'

    @base_path = request.original_fullpath.chomp('/')

    # We have to strip the last section off if it matches any code languages. Hacky, but it works
    DocumentationConstraint.code_language_list.map(&:downcase).each do |lang|
      @base_path.gsub!(%r{/#{lang}$}, '')
    end

    render layout: 'page'
  end

  def show
    @document_path = "_tutorials/#{@document}.md"

    # Read document
    document = File.read("#{Rails.root}/#{@document_path}")

    # Parse frontmatter
    @frontmatter = YAML.safe_load(document)
    @document_title = @frontmatter['title']

    @content = MarkdownPipeline.new({ code_language: @code_language, disable_label_filter: true }).call(document)

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
