class TutorialController < ApplicationController
  before_action :set_navigation
  before_action :set_tutorial_step
  before_action :set_tutorial
  before_action :check_tutorial_step

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
