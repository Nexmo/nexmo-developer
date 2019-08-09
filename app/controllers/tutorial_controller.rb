class TutorialController < ApplicationController
  before_action :set_navigation
  before_action :set_tutorial_step
  before_action :set_tutorial, except: [:list]
  before_action :check_tutorial_step, except: [:list]

  def list
    @product = params['product']
    @language = params['code_language']

    if @product
      @tutorials = TutorialList.tasks_for_product(@product)
    else
      @tutorials = TutorialList.all
    end

    @document_title = 'Use Cases'

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

    @hide_card_wrapper = true
    render layout: 'documentation'
  end

  private

  def set_navigation
    # Configure our sidebar navigation
    @namespace_root = '_documentation'
    @sidenav_root = "#{Rails.root}/_documentation"
    @navigation = :tutorials
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

  def tutorial_root
    "#{Rails.root}/_tutorials"
  end
end
