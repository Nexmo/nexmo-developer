class DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_additional_scripts

  def stats
    @feedbacks = Feedback::Feedback.created_between(created_after, created_before)

    @feedbacks = @feedbacks.joins(:resource).where(feedback_resources: { product: product }) if product
  end

  def stats_summary
    return unless created_after || created_before
    @feedbacks = Feedback::Feedback.created_between(created_after, created_before).joins(:resource)

    grouped_results = @feedbacks.group(["DATE_TRUNC('month', feedback_feedbacks.created_at)", 'feedback_resources.product', 'feedback_feedbacks.sentiment']).count(:id)

    # Reformat in to something usable
    @summary = {}
    grouped_results.each do |meta, count|
      month = meta[0]
      prod = meta[1] # Can't call it product due to the method defined in this class
      sentiment = meta[2]
      next unless prod # We have some feedback from non-product pages. Let's ignore that for now
      @summary[prod] = @summary[prod] || {}
      @summary[prod][month] = @summary[prod][month] || {}
      @summary[prod][month][sentiment] = count
    end

    # Sort by product, then by month
    @summary = @summary.sort.to_h

    @summary.each do |product, data|
      @summary[product] = data.sort.to_h
    end
  end

  def coverage
    @supported_languages = %w[
      curl
      csharp
      java
      node
      php
      python
      ruby
      json
      xml
    ]
    @product = product

    @complete_coverage = {}

    coverage_from_yaml if ['all', 'yaml'].include?(only)
    coverage_from_files if ['all', 'file'].include?(only)
    coverage_from_unsupported

    ignore_languages.each do |lang|
      @supported_languages.delete(lang)
    end

    if hide_response
      @supported_languages.delete('json')
      @supported_languages.delete('xml')
    end

    @toplevel_summary = {}
    @complete_coverage.each do |toplevel, blocks|
      @toplevel_summary[toplevel] = { 'blocks' => 0, 'langs' => {} } unless @toplevel_summary[toplevel]
      blocks.each do |_section, entries|
        entries.each do |_name, languages|
          @toplevel_summary[toplevel]['blocks'] += 1
          @supported_languages.each do |lang|
            @toplevel_summary[toplevel]['langs'][lang] = 0 unless @toplevel_summary[toplevel]['langs'][lang]
            @toplevel_summary[toplevel]['langs'][lang] += 1 if languages[lang]
          end
        end
      end
    end

    # Remove non-GA features
    if params[:show_ga_only]
      params[:ignore_products] = 'conversation,messages,dispatch,audit,vonage-business-cloud'
    end
    params[:ignore_products]&.split(',')&.each do |key|
      @complete_coverage.delete(key)
      @toplevel_summary.delete(key)
    end

    # Calculate the overall summary
    @overall_summary = { 'blocks' => 0, 'langs' => {} }
    @supported_languages.each do |lang|
      @overall_summary['langs'][lang] = 0
    end

    @toplevel_summary.each do |_title, summary|
      @overall_summary['blocks'] += summary['blocks']
      summary['langs'].each do |lang, value|
        @overall_summary['langs'][lang] += value
      end
    end
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

  def coverage_from_unsupported
    Dir.glob("#{Rails.root}/_examples/**/.unsupported.yml").each do |e|
      relative_path = e.gsub("#{Rails.root}/_examples/", '')
      parts = relative_path.split('/')
      parts.insert(1, 'top-level') if parts.count < 4
      parts = parts[0..-2]
      next if parts[0] == 'migrate'

      excluded_content = YAML.load_file(e)

      x = @complete_coverage
      parts.each do |key, _value|
        x[key] = {} unless x[key]
        x = x[key]
      end
      excluded_content.each do |language|
        x[language] = {
          'type' => 'unsupported',
        }
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
      next if parts[0] == 'migrate'

      x = @complete_coverage
      parts.each do |key, _value|
        x[key] = {} unless x[key]
        x = x[key]
      end

      language = source.gsub('.yml', '').downcase
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

      parts.insert(1, 'top-level') if parts.count < 3

      parts = [parts[0], parts[1], parts[2..-1].join('/')] if parts.count > 3
      next if parts[0] == 'migrate'

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
