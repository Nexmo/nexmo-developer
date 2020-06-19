class Footer
  attr_reader :items

  def initialize(items: nil)
    @items = items

    after_initialize!
  end

  def footer_from_config(config)
    config = YAML.safe_load(open_config(config))
    {
      name: config['name'],
      subtitle: config['subtitle'],
      logo_path: config['assets']['footer_logo']['path'],
      logo_alt: config['assets']['footer_logo']['alt'],
      status: config['footer']['links']['status'],
      social_links: config['footer']['links']['social'],
      navigation_links: config['footer']['links']['navigation'],
      support_links: config['footer']['links']['support'],
    }
  end

  def self.navigation_category_titleize(title)
    if title.include?('-')
      title_split = title.split('-').map do |word|
        word == 'api' ? word.upcase : word.titleize
      end
      title = title_split.join(' ')
    else
      title = title.titleize
    end
    title
  end

  def self.navigation_link(link)
    link.values.join(' ')
  end

  def self.navigation_link_text(link)
    text = link.keys.join(' ')
    if text.include?('-')
      link_split = text.split('-').map do |word|
        if word == 'api'
          word.upcase
        elsif word == 'apis'
          word = 'APIs'
        else
          word.titleize
        end
      end
      link = link_split.join(' ')
    elsif text == 'sms'
      link = text.upcase
    else
      link = text.titleize
    end
    link
  end

  def self.support_link(link)
    if link.include?('@')
      "mailto:#{link}"
    else
      link
    end
  end

  def self.support_link_text(link)
    link.titleize
  end

  def open_config(config)
    File.open(config)
  end

  def config_exist?(path)
    File.exist?(path)
  end

  private

  def after_initialize!
    raise 'You must provide a config/business_info.yml file in your documentation path.' unless config_exist?("#{Rails.configuration.docs_base_path}/config/business_info.yml")

    @items = footer_from_config("#{Rails.configuration.docs_base_path}/config/business_info.yml")
  end
end
