class Header
  def initialize
    after_initialize!
  end

  def logo_path
    @logo_path ||= config['assets']['header_logo']['path']
  end

  def small_logo_path
    @small_logo_path ||= config['assets']['header_logo']['small_path'] ||
                         config['assets']['header_logo']['path']
  end

  def logo_alt
    @logo_alt ||= config['assets']['header_logo']['alt']
  end

  def name
    @name ||= config['name']
  end

  def subtitle
    @subtitle ||= config['subtitle']
  end

  def hiring_link?
    hiring_display
  end

  def sign_up_path
    @sign_up_path ||= config['header']['links']['sign-up']['path']
  end

  def sign_up_text
    @sign_up_text ||= config['header']['links']['sign-up']['text']
  end

  private

  def after_initialize!
    raise 'You must provide a config/business_info.yml file in your documentation path.' unless File.exist?("#{Rails.configuration.docs_base_path}/config/business_info.yml")
  end

  def config
    @config ||= YAML.safe_load(
      File.open("#{Rails.configuration.docs_base_path}/config/business_info.yml")
    )
  end

  def hiring_display
    raise 'You must provide a true or false value for the hiring display parameter inside the header section of the config/business_info.yml file' unless config['header']['hiring'].try(:has_key?, 'display')

    config['header']['hiring']['display']
  end
end
