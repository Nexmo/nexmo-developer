class Topnav
  CONFIG = "#{Rails.configuration.docs_base_path}/config/top_navigation.yml".freeze

  def initialize(navigation)
    @navigation = navigation

    after_initialize!
  end

  def items
    @items ||= begin
      YAML.safe_load(File.open(CONFIG)).map do |name, url|
        TopnavItem.new(name, url, @navigation)
      end
    end
  end

  private

  def after_initialize!
    raise 'You must provide a config/top_navigation.yml file in your documentation path.' unless File.exist?(CONFIG)
  end
end
