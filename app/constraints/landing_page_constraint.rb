class LandingPageConstraint
  def self.filename?(params)
    if File.exists?("/config/landing_pages/#{params}")
      params 
    end
  end
end