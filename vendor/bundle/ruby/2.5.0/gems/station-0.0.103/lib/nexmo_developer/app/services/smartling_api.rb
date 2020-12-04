class SmartlingAPI
  include ::Translator::Utils

  def initialize(user_id:, user_secret:, project_id:)
    @client = Smartling::File.new(
      userId: user_id,
      userSecret: user_secret,
      projectId: project_id
    )
  end

  def upload(filename)
    file_uri = file_uri(filename)
    file = Tempfile.new
    file.write Nexmo::Markdown::Pipelines::Smartling::Preprocessor.new.call(
      File.read("#{Rails.configuration.docs_base_path}/#{filename}")
    )
    file.rewind

    wrap_in_rescue do
      @client.upload(
        file.path,
        file_uri,
        file_type(filename),
        'smartling.markdown_code_notranslate': true
      )
    end
  ensure
    file.close
    file.unlink
  end

  def file_type(filename)
    case Pathname.new(filename).extname
    when '.md', '.markdown'
      'markdown'
    when '.yml', '.yaml'
      'yaml'
    else
      raise 'Unsupported file type.'
    end
  end

  def last_modified(filename:, locale:)
    file_uri = file_uri(filename)
    wrap_in_rescue { @client.last_modified(file_uri, locale) }
  end

  def download_translated(filename:, locale:, type: :published)
    file_uri = file_uri(filename)
    wrap_in_rescue do
      response = @client.download_translated(file_uri, locale, retrievalType: type)

      locale = locale_without_region(locale.to_s)
      folder = storage_folder(filename, locale)
      FileUtils.mkdir_p(folder) unless File.exist?(folder)
      File.open(file_path(filename, locale), 'w+') do |file|
        file.write(Nexmo::Markdown::Pipelines::Smartling::Download.call(response))
      end
    end
  end

  private

  def wrap_in_rescue
    yield
  rescue StandardError => e
    p e.message # rubocop:disable Rails/Output
    Bugsnag.notify(e)
    Rails.logger.error(e.message)
  end
end
