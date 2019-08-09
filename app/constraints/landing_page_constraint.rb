class LandingPageConstraint
  def self.matches?
    { landing_page: Regexp.new(list.join('|')) }
  end

  def self.list
    root = "#{Rails.root}/config/landing_pages/"
    Dir["#{root}/**/*.yml"].map do |filename|
      name = File.join(File.dirname(filename), File.basename(filename, '.yml')).gsub(root, '')
      name[0] = '' if name[0] == '/' # Remove leading slash for subdirectories
      name
    end
  end
end
