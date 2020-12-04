class FeedbackPresenter
  def initialize(canonical_url, params)
    @canonical_url = canonical_url
    @params        = params
  end

  def props
    config.merge(
      'source' => @canonical_url,
      'configId' => feedback_config.id,
      'codeLanguage' => @params[:code_language],
      'codeLanguageSetByUrl' => @params[:code_language].present?
    )
  end

  def show_feedback?
    File.exist?(config_file_path)
  end

  def config
    @config ||= YAML.safe_load(File.read(config_file_path))
  end

  def config_file_path
    "#{Rails.configuration.docs_base_path}/config/feedback.yml"
  end

  def feedback_config
    @feedback_config ||= Feedback::Config.find_or_create_config(config)
  end
end
