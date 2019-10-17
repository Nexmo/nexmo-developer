class SmartlingAPI
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
    file.write I18n::FrontmatterFilter.new.call(File.read(filename))
    file.rewind

    wrap_in_rescue do
      @client.upload(
        file.path,
        file_uri,
        'markdown',
        'smartling.markdown_code_notranslate': true
      )
    end
  ensure
    file.close
    file.unlink
  end

  def last_modified(filename:, locale:)
    file_uri = file_uri(filename)
    wrap_in_rescue { @client.last_modified(file_uri, locale) }
  end

  def download_translated(filename:, locale:, type: :published)
    file_uri = file_uri(filename)
    wrap_in_rescue { @client.download_translated(file_uri, locale, retrievalType: type) }
  end

  private

  def file_uri(filename)
    filename.gsub(%r{_documentation\/[a-z]{2}\/}, '')
  end

  def wrap_in_rescue
    yield
  rescue StandardError => e
    Bugsnag.notify(e)
    Rails.logger.error(e.message)
  end
end
