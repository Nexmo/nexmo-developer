class LandingPageConstraint
  def self.matches?
    # This is the base path to our config files, that we'll be stripping off
    root = "#{Rails.root}/config/landing_pages/"

    # Format the landing page list as required, removing the base path and config folder
    available_pages = Dir["#{root}/**/*.yml"].map do |filename|
      name = File.join(File.dirname(filename), File.basename(filename, '.yml')).gsub(root, '')
      name[0] = '' if name[0] == '/' # Remove leading slash for subdirectories
      name
    end

    { landing_page: Regexp.new(available_pages.join('|')) }
  end
end
