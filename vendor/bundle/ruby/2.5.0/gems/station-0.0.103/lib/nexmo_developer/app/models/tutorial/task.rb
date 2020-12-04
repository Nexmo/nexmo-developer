class Tutorial::Task
  attr_reader :name, :title, :description, :current_step

  def initialize(name:, title:, description:, current_step:)
    @name         = name
    @title        = title
    @description  = description
    @current_step = current_step
  end

  def active?
    @name == @current_step
  end

  def self.make_from(name:, code_language:, current_step:)
    file_loader = Tutorial::FileLoader.new(
      root: Tutorial.task_content_path,
      doc_name: name,
      code_language: code_language,
      format: 'md'
    )

    new(
      name: name,
      title: file_loader.yaml['title'],
      description: file_loader.yaml['description'],
      current_step: current_step
    )
  end

  def ==(other)
    name == other.name &&
      title == other.title &&
      description == other.description &&
      current_step == other.current_step
  end

  def eql?(other)
    self == other
  end

  def hash
    name.hash ^ title.hash ^ description.hash ^ current_step.hash
  end
end
