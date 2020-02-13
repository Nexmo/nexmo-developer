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
    file.write I18n::FrontmatterFilter.new.call(
      File.read("#{Rails.configuration.docs_base_path}/#{filename}")
    )
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
    wrap_in_rescue do
      response = @client.download_translated(file_uri, locale, retrievalType: type)

      locale = locale_without_region(locale.to_s)
      FileUtils.mkdir_p(storage_folder(locale, filename)) unless File.exist?(storage_folder(locale, filename))
      File.open("#{Rails.configuration.docs_base_path}/_documentation/#{locale}/#{file_uri}", 'w+') do |file|
        file.write(I18n::SmartlingConverterFilter.call(response))
      end
    end
  end

  private

  def locale_without_region(locale)
    ['zh-CN', 'cn'].include?(locale) ? :cn : :en
  end

  def storage_folder(locale, filename)
    dir_path = Pathname.new(file_uri(filename)).dirname.to_s
    "#{Rails.configuration.docs_base_path}/_documentation/#{locale}/#{dir_path}/"
  end

  def file_uri(filename)
    filename.gsub(%r{_documentation\/[a-z]{2}\/}, '')
  end

  def wrap_in_rescue
    yield
  rescue StandardError => e
    p e.message # rubocop:disable Rails/Output
    Bugsnag.notify(e)
    Rails.logger.error(e.message)
  end
end
