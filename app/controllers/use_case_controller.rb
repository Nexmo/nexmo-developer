class UseCaseController < ApplicationController
  before_action :set_navigation

  def index
    @product = params['product']
    @language = params['code_language']

    @use_cases = Nexmo::Markdown::UseCase.all

    @use_cases = Nexmo::Markdown::UseCase.by_product(@product, @use_cases) if @product
    @use_cases = Nexmo::Markdown::UseCase.by_language(@language, @use_cases) if @language

    @document_title = 'Use Cases'

    excluded_languages = ['csharp', 'javascript', 'kotlin', 'android', 'swift', 'objective_c']
    @languages = Nexmo::Markdown::CodeLanguage.languages.reject { |l| excluded_languages.include?(l.key) }

    render layout: 'page'
  end

  def show
    # Read document
    @document_path = Nexmo::Markdown::DocFinder.find(
      root: "#{Rails.configuration.docs_base_path}/_use_cases",
      document: params[:document],
      language: I18n.locale,
      code_language: params[:code_language]
    ).path
    @document = File.read(@document_path)

    # Parse frontmatter
    @frontmatter = YAML.safe_load(@document)

    @document_title = @frontmatter['title']
    @product = @frontmatter['products']

    @content = Nexmo::Markdown::Renderer.new(
      code_language: @code_language,
      locale: params[:locale]
    ).call(@document)

    @sidenav = Sidenav.new(
      namespace: params[:namespace],
      locale: params[:locale],
      request_path: request.path,
      navigation: @navigation,
      code_language: params[:code_language],
      product: @product
    )

    render layout: 'documentation'
  end

  private

  def set_navigation
    @navigation = :use_case
  end
end
