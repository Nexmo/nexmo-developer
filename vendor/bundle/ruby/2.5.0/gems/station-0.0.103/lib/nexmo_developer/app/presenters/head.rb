class Head
  class Description
    def initialize(config:, frontmatter:)
      @config      = config
      @frontmatter = frontmatter
    end

    def description
      @description ||= from_frontmatter || @config.fetch('description') do
        raise "You must provide a 'description' parameter in header_meta.yml"
      end
    end

    def from_frontmatter
      @frontmatter && (@frontmatter['meta_description'] || @frontmatter['description'])
    end
  end

  attr_reader :config, :frontmatter

  def initialize(frontmatter = nil)
    @frontmatter = frontmatter

    after_initialize!
    validate_files_presence!
  end

  def title
    @title ||= config.fetch('title') do
      raise "You must provide a 'title' parameter in header_meta.yml"
    end
  end

  def description
    @description ||= Description.new(config: config, frontmatter: frontmatter).description
  end

  def google_site_verification
    @google_site_verification ||= config['google-site-verification']
  end

  def application_name
    @application_name ||= config['application-name']
  end

  def favicon
    'meta/favicon.ico'
  end

  def favicon_32_squared
    'meta/favicon-32x32.png'
  end

  def manifest
    'meta/manifest.json'
  end

  def safari_pinned_tab
    'meta/safari-pinned-tab.svg'
  end

  def mstile_144_squared
    'meta/mstile-144x144.png'
  end

  def apple_touch_icon
    'meta/apple-touch-icon.png'
  end

  def og_image
    @og_image ||= "meta/#{config['og-image']}"
  end

  def og_image_width
    @og_image_width ||= config['og-image-width']
  end

  def og_image_height
    @og_image_height ||= config['og-image-height']
  end

  private

  def after_initialize!
    config_path = "#{Rails.configuration.docs_base_path}/config/header_meta.yml"
    raise 'You must provide a config/header_meta.yml file in your documentation path.' unless File.exist?(config_path)

    @config = YAML.safe_load(File.open(config_path))
  end

  def validate_files_presence!
    %i[favicon favicon_32_squared manifest safari_pinned_tab mstile_144_squared apple_touch_icon og_image].each do |file|
      raise "You must provide a #{send(file).sub('meta/', '')} file inside the public/meta directory" unless File.exist?("#{Rails.configuration.docs_base_path}/public/#{send(file)}")
    end
  end
end
