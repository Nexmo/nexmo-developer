OPEN_API_PRODUCTS = %w[
  sms
  media
  number-insight
  conversation
  messages-olympus
  dispatch
  redact
  audit
  voice
  account
  external-accounts
  verify
  vonage-business-cloud/account
  vonage-business-cloud/extension
  vonage-business-cloud/user
  application.v2
].freeze

class OpenApiConstraint
  def self.list
    OPEN_API_PRODUCTS
  end

  def self.products
    { definition: Regexp.new(OPEN_API_PRODUCTS.join('|')) }
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
end
