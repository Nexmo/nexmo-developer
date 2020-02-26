class TutorialController < ApplicationController
  before_action :set_navigation
  before_action :set_tutorial_step
  before_action :set_tutorial, except: %i[list single]
  before_action :check_tutorial_step, except: %i[list single]
  before_action :set_sidenav

  def list
    @product = params['product']
    @code_language = params['code_language']

    if @product
      @tutorials = TutorialList.tasks_for_product(@product)
    else
      @tutorials = TutorialList.all
    end

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
      { 'path' => 'account/subaccounts', 'icon' => 'user', 'icon_colour' => 'blue', 'name' => 'Subaccounts' },
    ]

    render layout: 'page'
  end

  def index
    if @tutorial_step == 'prerequisites'
      @content = render_to_string(partial: 'prerequisites', layout: false)
    else
      @content = MarkdownPipeline.new({
        code_language: @code_language,
        current_user: current_user,
      }).call(@tutorial.content_for(@tutorial_step))
    end

    # If it's an intro/conclusion we can't link to a specific task, so make sure that
    # we're linking to a non-product tutorial link as the canonical link
    if ['introduction', 'conclusion'].include?(@tutorial_step)
      @canonical_url = helpers.canonical_base + request.original_fullpath.gsub(%r{^/#{params[:product]}}, '')
    else
      # Otherwise it's a single step, which we can link to
      @canonical_url = "#{helpers.canonical_base}/task/#{@tutorial_step}"
    end

    @hide_card_wrapper = true
    render layout: 'documentation'
  end

  def single
    path = "#{Rails.root}/_tutorials/#{I18n.default_locale}/#{params[:tutorial_step]}.md"
    @content = File.read(path)
    @content = MarkdownPipeline.new({
                                      code_language: @code_language,
                                      current_user: current_user,
                                    }).call(@content)
    render layout: 'documentation'
  end

  private

  def set_navigation
    @navigation = :tutorials
  end

  def set_sidenav
    @sidenav = Sidenav.new(
      namespace: params[:namespace],
      language: @language,
      request_path: request.path,
      navigation: @navigation,
      code_language: params[:code_language],
      product: params[:product]
    )
  end

  def set_tutorial
    @tutorial_name = params[:tutorial_name]
    render_not_found unless @tutorial_name
    @tutorial = Tutorial.load(@tutorial_name, @tutorial_step, params[:product])
  end

  def set_tutorial_step
    return unless params[:tutorial_step]

    @tutorial_step = params[:tutorial_step]
  end

  def check_tutorial_step
    # If we don't have a current tutorial step, redirect to the first available page
    return if @tutorial_step

    redirect_to "/#{@tutorial.current_product}/tutorials/#{@tutorial.name}/#{@tutorial.first_step}"
  end
end
