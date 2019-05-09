class TaskController < ApplicationController
  before_action :set_navigation
  before_action :set_task
  before_action :set_task_step

  def index
    @task = Task.load(@task_name, @task_step)
    @product = @task.product

    # If we don't have a current task step, redirect to the first available page
    unless @task_step
      return redirect_to "/task/#{@task.name}/#{@task.first_step}"
    end

    if @task_step == 'prerequisites'
      @content = render_to_string(partial: 'prerequisites', layout: false)

    else
      @content = MarkdownPipeline.new({
                                        code_language: @code_language,
                                        current_user: current_user,
                                      }).call(@task.content_for(@task_step))
    end

    @hide_card_wrapper = true
    render layout: 'documentation'
  end

  private

  def set_navigation
    # Configure our sidebar navigation
    @namespace_root = '_documentation'
    @sidenav_root = "#{Rails.root}/_documentation"
  end

  def set_task
    @task_name = params[:task_name]
    render_not_found unless @task_name
  end

  def set_task_step
    return unless params[:task_step]
    @task_step = params[:task_step]
  end

  def task_root
    "#{Rails.root}/_tasks"
  end
end
