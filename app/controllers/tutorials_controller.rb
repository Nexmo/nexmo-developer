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

    excluded_languages = ['csharp', 'javascript', 'kotlin', 'android', 'swift', 'objective_c']
    @languages = CodeLanguage.languages.reject { |l| excluded_languages.include?(l.key) }

    @products = [
      { 'path' => 'messaging/sms', 'icon' => 'message', 'icon_colour' => 'purple', 'name' => 'SMS' },
      { 'path' => 'voice/voice-api', 'icon' => 'phone', 'icon_colour' => 'green', 'name' => 'Voice' },
      { 'path' => 'verify', 'icon' => 'lock', 'icon_colour' => 'purple-dark', 'name' => 'Verify' },
      { 'path' => 'messages', 'icon' => 'chat', 'icon_colour' => 'blue', 'name' => 'Messages' },
      { 'path' => 'dispatch', 'icon' => 'flow', 'icon_colour' => 'blue', 'name' => 'Dispatch' },
      { 'path' => 'number-insight', 'icon' => 'file-search', 'icon_colour' => 'orange', 'name' => 'Number Insight' },
      { 'path' => 'conversation', 'icon' => 'message', 'icon_colour' => 'blue', 'name' => 'Conversation' },
      { 'path' => 'client-sdk', 'icon' => 'queue', 'icon_colour' => 'blue', 'name' => 'Client SDK' },
      { 'path' => 'subaccounts', 'icon' => 'queue', 'icon_colour' => 'blue', 'name' => 'Subaccounts' },
    ]

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

    @content = MarkdownPipeline.new({ code_language: @code_language }).call(document)

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
