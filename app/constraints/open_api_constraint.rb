OPEN_API_PRODUCTS = %w[
  sms
  media
  number-insight
  conversation
  conversation.v2
  messages-olympus
  dispatch
  redact
  audit
  voice.v2
  voice
  account
  external-accounts
  numbers
  verify
  vonage-business-cloud/account
  vonage-business-cloud/extension
  vonage-business-cloud/reports
  vonage-business-cloud/user
  vonage-business-cloud/vgis
  application.v2
  application
  reports
  conversion
  subaccounts
  developer/messages
  pricing
].freeze

class OpenApiConstraint
  def self.list
    OPEN_API_PRODUCTS
  end

  def self.products
    { definition: Regexp.new("^(#{OPEN_API_PRODUCTS.join('|')})$") }
  end

  def self.errors_available
    all = OPEN_API_PRODUCTS.dup.concat(['application'])
    { definition: Regexp.new(all.join('|')) }
  end

  def self.products_with_code_language
    products.merge(CodeLanguage.route_constraint)
  end

  def self.find_all_versions(name)
    # Remove the .v2 etc if needed
    name = name.gsub(/(\.v\d+)/, '')

    matches = OPEN_API_PRODUCTS.select do |s|
      s.starts_with?(name) && !s.include?("#{name}/")
    end

    matches = matches.map do |s|
      m = /\.v(\d+)/.match(s)
      next { 'version' => '1', 'name' => s } unless m
      { 'version' => m[1], 'name' => s }
    end

    matches.sort_by { |v| v['version'] }
  end

  def self.match?(definition, code_language = nil)
    if code_language.nil?
      products_with_code_language[:definition].match?(definition)
    else
      products_with_code_language[:definition].match?(definition) &&
        products_with_code_language[:code_language].match?(code_language)
    end
  end
end
