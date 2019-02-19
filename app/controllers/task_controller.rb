class TaskController < ApplicationController
  before_action :set_task
  before_action :set_task_step

  def index
    # Load the task file from config
    task_path = "#{Rails.root}/config/tasks/#{@task}.yml"
    return not_found unless File.exist? task_path
    task_config = YAML.safe_load(File.read(task_path))
    tasks = task_config['tasks']

    # If we don't have a current task step, redirect to the first one
    unless @task_step
      first_task = tasks[0].gsub('/', '--')
      return redirect_to "/task/#{@task}/#{first_task}"
    end

    # If we do have a task, load it
    step_path = "#{task_root}/#{@task_step}.md"
    return not_found unless File.exist? step_path
    step_content = File.read(step_path)
    @content = MarkdownPipeline.new.call(step_content)

    # Generate complete task navigation
    @subtasks = tasks.map do |t|
      t_path = "#{task_root}/#{t}.md"
      raise "Subtask not found: #{t}" unless File.exist? (t_path)
      task_config = YAML.safe_load(File.read(t_path))
      next {
        'path' => t,
        'title' => task_config['title'],
        'description' => task_config['description']
      }
    end

    # What's the next link in this task?
    current_task_index = tasks.index(@task_step)
    @next_task = current_task_index + 1

    # How about the previous?
    @previous_task = current_task_index - 1
    if @previous_task < 0
      @previous_task = nil
    end

    #@content = "Hello World"
    @sidebar_nav = "This would be section nav, if it existed"

    render layout: 'documentation'
  end

  def not_found
    render 'static/404', status: :not_found, formats: [:html]
  end

  private

  def set_task
    @task = params[:task_name]
    return not_found unless @task
  end

  def set_task_step
    return unless params[:task_step]
    @task_step = params[:task_step].gsub('--', '/')
  end

  def task_root
    "#{Rails.root}/_tasks"
  end

end
