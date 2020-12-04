class LocaleSwitcherPresenter
  LOCALES = {
    'cn' => '简体中文',
    'en' => 'English',
    'ja' => '日本語',
  }.freeze

  def initialize(request)
    @request = request
  end

  def disabled?
    @request.controller_class == ActionDispatch::Request::PASS_NOT_FOUND
  end

  def current_locale
    LOCALES[I18n.locale.to_s]
  end

  def locales
    @locales ||= available_locales.map do |l|
      OpenStruct.new(data: l, value: LOCALES[l])
    end
  end

  def available_locales
    @available_locales ||= begin
      root = "#{Rails.configuration.docs_base_path}/_documentation"
      Dir["#{root}/*"].map { |path| path.gsub("#{root}/", '') }
    end
  end

  def multiple_locales?
    locales.length > 1
  end
end
