class Tutorial
  include ActiveModel::Model

  attr_reader :name, :current_step

  delegate :path, :yaml, to: :@file_loader
  delegate :available_code_languages, to: :metadata

  def initialize(name:, current_step:, current_product: nil, code_language: nil)
    @name         = name
    @current_step = current_step
    @product      = current_product
    @language     = code_language
    @file_loader  = load_file!
  end

  def metadata
    @metadata ||= Metadata.new(name: name)
  end

  def current_product
    @current_product ||= @product || metadata.default_product
  end

  def code_language
    @code_language ||= @language || metadata.code_language
  end

  def title
    @title ||= yaml['title'] || metadata.title
  end

  def description
    @description ||= yaml['description'] || metadata.description
  end

  def products
    @products ||= yaml['products'] || metadata.products
  end

  def prerequisites
    @prerequisites ||= (yaml['prerequisites'] || []).map do |prereq|
      Prerequisite.new(name: prereq, code_language: code_language, current_step: current_step)
    end
  end

  def content_for(step_name)
    if ['introduction', 'conclusion'].include? step_name
      raise "Invalid step: #{step_name}" unless yaml[step_name]

      return yaml[step_name]['content']
    end

    path = Nexmo::Markdown::DocFinder.find(
      root: self.class.task_content_path,
      document: step_name,
      language: ::I18n.locale,
      code_language: code_language
    ).path

    File.read(path)
  end

  def first_step
    subtasks.first&.name
  end

  def prerequisite?
    prerequisites.map(&:name).include?(@current_step)
  end

  def next_step
    current_task_index = subtasks.map(&:name).index(@current_step)
    return nil unless current_task_index

    subtasks[current_task_index + 1]
  end

  def previous_step
    current_task_index = subtasks.map(&:name).index(@current_step)
    return nil unless current_task_index
    return nil if current_task_index <= 0

    subtasks[current_task_index - 1]
  end

  def subtasks
    @subtasks ||= begin
      tasks = []

      (yaml['tasks'] || []).map do |t|
        tasks.push(
          Task.make_from(
            name: t,
            code_language: code_language,
            current_step: current_step
          )
        )
      end

      tasks.unshift(prerequisite_task)
      tasks.unshift(introduction_task)
      tasks.push(conclusion_task)

      tasks.compact
    end
  end

  def self.load_prerequisites(prerequisites, current_step)
    return [] unless prerequisites

    prerequisites.map do |t|
      t_path = Nexmo::Markdown::DocFinder.find(
        root: task_content_path,
        document: t,
        language: ::I18n.locale
      ).path
      raise "Prerequisite not found: #{t}" unless File.exist? t_path

      content = File.read(t_path)
      prereq = YAML.safe_load(content)
      {
        'path' => t,
        'title' => prereq['title'],
        'description' => prereq['description'],
        'is_active' => t == current_step,
        'content' => content,
      }
    end
  end

  def prerequisite_task
    return if prerequisites.empty?

    Task.new(
      name: 'prerequisites',
      title: 'Prerequisites',
      description: 'Everything you need to complete this task',
      current_step: current_step
    )
  end

  def introduction_task
    return unless yaml['introduction']

    Task.new(
      name: 'introduction',
      title: yaml['introduction']['title'],
      description: yaml['introduction']['description'],
      current_step: current_step
    )
  end

  def conclusion_task
    return unless yaml['conclusion']

    Task.new(
      name: 'conclusion',
      title: yaml['conclusion']['title'],
      description: yaml['conclusion']['description'],
      current_step: current_step
    )
  end

  def self.load(name, current_step, current_product = nil, code_language = nil)
    new(
      name: name,
      current_step: current_step,
      current_product: current_product,
      code_language: code_language
    )
  end

  def load_file!
    Tutorial::FileLoader.new(
      root: self.class.tutorials_path,
      code_language: code_language,
      doc_name: name
    )
  end

  def self.task_content_path
    "#{Nexmo::Markdown::Config.docs_base_path}/_tutorials"
  end

  def self.tutorials_path
    "#{Nexmo::Markdown::Config.docs_base_path}/config/tutorials"
  end
end
