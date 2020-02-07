class Tutorial::Prerequisite
  delegate :content, :yaml, to: :@file_loader

  def initialize(current_step:, code_language:, name:)
    @current_step  = current_step
    @code_language = code_language
    @name          = name
    @file_loader   = load_file!
  end

  def title
    @title ||= yaml['title']
  end

  def description
    @description ||= yaml['description']
  end

  def active?
    @name == @current_step
  end

  def load_file!
    Tutorial::FileLoader.new(
      root: Tutorial.task_content_path,
      code_language: nil,
      doc_name: @name,
      format: 'md'
    )
  end
end
