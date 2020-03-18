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
    file.write Nexmo::Markdown::I18n::FrontmatterFilter.new.call(
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
        file.write(Nexmo::Markdown::I18n::SmartlingConverterFilter.call(response))
      end
    end
  end

  private

  def file_path(filename, locale)
    folder = storage_folder(filename, locale)
    file_name = if filename.starts_with? '_documentation'
                  Pathname.new(file_uri(filename)).basename.to_s
                elsif filename.starts_with? 'config/locales'
                  "#{locale}#{Pathname.new(file_uri(filename)).extname}"
                end
    "#{folder}/#{file_name}"
  end

  def locale_without_region(locale)
    ['zh-CN', 'cn'].include?(locale) ? :cn : :en
  end

  def storage_folder(filename, locale)
    if filename.starts_with? '_documentation'
      dir_path = Pathname.new(file_uri(filename)).dirname.to_s
      "#{Rails.configuration.docs_base_path}/_documentation/#{locale}/#{dir_path}"
    elsif filename.starts_with? 'config/locales'
      Pathname.new(file_uri(filename)).dirname.to_s
    else
      raise 'Unexpected file path'
    end
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
