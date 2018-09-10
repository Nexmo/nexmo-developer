class DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_additional_scripts

  def stats
    @feedbacks = Feedback::Feedback

    if product
      @feedbacks = @feedbacks.joins(:resource).where(feedback_resources: { product: product })
    end

    if created_after && created_before
      @feedbacks = @feedbacks.created_between(created_after, created_before)
    elsif created_after
      @feedbacks = @feedbacks.created_after(created_after)
    elsif created_before
      @feedbacks = @feedbacks.created_before(created_before)
    end
  end

  def coverage
    @supported_languages = %w[
      curl
      httpie
      csharp
      dotnet
      java
      node
      php
      python
      ruby
      json
      xml
    ]
    @product = product.tr('-', '_') if product

    @complete_coverage = {}

    coverage_from_config if ['all', 'config'].include?(only)
    coverage_from_yaml if ['all', 'yaml'].include?(only)
    coverage_from_files if ['all', 'file'].include?(only)

    ignore_languages.each do |lang|
      @supported_languages.delete(lang)
    end

    return unless hide_response

    @supported_languages.delete('json')
    @supported_languages.delete('xml')
  end

  private

  def set_additional_scripts
    @additional_scripts = ['stats']
  end

  def ignore_languages
    return params[:ignore].split(',') if params[:ignore].present?
    []
  end

  def only
    return params[:only] if params[:only].present?
    'all'
  end

  def product
    params[:product].presence
  end

  def created_before
    @created_before ||= params[:created_before] if params[:created_before].present?
  end

  def created_after
    @created_after ||= params[:created_after] if params[:created_after].present?
  end

  def hide_response
    params[:hide_response].presence
  end

  def coverage_from_config
    configs = YAML.load_file("#{Rails.root}/config/code_examples.yml")
    configs.each do |type, value|
      value.each do |subheader, entries|
        coverage_from_config_items(subheader, entries, [type])
      end
    end
  end

  def coverage_from_config_items(language, items, stack)
    stack = stack.clone
    if @supported_languages.include?(language)
      source_path = stack.join('.')

      stack.insert(1, 'top-level') if stack.count < 3

      stack = [stack[0], stack[1], stack[2..-1].join('/')] if stack.count > 3

      x = @complete_coverage
      stack.each do |key, _value|
        x[key] = {} unless x[key]
        x = x[key]
      end

      language = language.downcase
      language = 'dotnet' if language == 'csharp'
      x[language] = {
          'source' =>  items['source'],
          'source_path' =>  'config: ' + source_path,
          'type' => 'config',
      }
    else
      stack = stack.clone
      stack << language
      items.each do |header, details|
        coverage_from_config_items(header, details, stack)
      end
    end
  end

  def coverage_from_yaml
    Dir.glob("#{Rails.root}/_examples/**/*.yml").each do |e|
      relative_path = e.gsub("#{Rails.root}/_examples/", '')
      source_path = "_examples/#{relative_path}"
      parts = relative_path.split('/')
      parts.insert(1, 'top-level') if parts.count < 4
      source = parts[-1]
      parts = parts[0..-2]

      x = @complete_coverage
      parts.each do |key, _value|
        x[key] = {} unless x[key]
        x = x[key]
      end

      language = source.gsub('.yml', '').downcase
      language = 'dotnet' if language == 'csharp'
      x[language] = {
          'source' =>  '_examples/' + relative_path,
          'source_path' => source_path,
          'type' => 'yaml',
      }
    end
  end

  def coverage_from_files
    Dir.glob("#{Rails.root}/_examples/**/*").each do |e|
      relative_path = e.gsub("#{Rails.root}/_examples/", '')
      next unless File.file?(e)
      next if File.extname(e) == '.md' # Markdown files are handled by the config coverage
      next if File.extname(e) == '.yml' # Yaml files are handled by yaml coverage

      source_path = e.clone
      parts = relative_path.split('/')
      language = parts.pop

      language = 'dotnet' if language == 'csharp'

      parts.insert(1, 'top-level') if parts.count < 3

      parts = [parts[0], parts[1], parts[2..-1].join('/')] if parts.count > 3

      x = @complete_coverage
      parts.each do |key, _value|
        x[key] = {} unless x[key]
        x = x[key]
      end

      x[language.downcase] = {
          'source' =>  '_examples/' + relative_path,
          'source_path' =>  source_path,
          'type' => 'file',
      }
    end
  end
end
