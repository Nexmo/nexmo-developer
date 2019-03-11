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
    CodeLanguage.linkable.map(&:key).map(&:downcase).each do |lang|
      @base_path.gsub!(%r{/#{lang}$}, '')
    end

    render layout: 'page'
  end

  def show
    # Read document
    @document_path = "_tutorials/#{@document}.md"
    document = File.read("#{Rails.root}/#{@document_path}")

    # Parse frontmatter
    @frontmatter = YAML.safe_load(document)

    @document_title = @frontmatter['title']
    @product = @frontmatter['products']

    @content = MarkdownPipeline.new({ code_language: @code_language, disable_label_filter: true }).call(document)

    @namespace_path = "_documentation/#{@product}"
    @namespace_root = '_documentation'
    @sidenav_root = "#{Rails.root}/_documentation"

    render layout: 'documentation'
  end

  private

  def set_document
    @document = params[:document]
  end

  def set_navigation
    @navigation = :tutorials
  end
end
