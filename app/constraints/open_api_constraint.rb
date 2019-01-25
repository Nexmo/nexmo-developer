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
  account/secret-management
  external-accounts
  verify
].freeze

class OpenApiConstraint
  def self.list
    OPEN_API_PRODUCTS
  end

  def self.products
    { definition: Regexp.new(OPEN_API_PRODUCTS.join('|')) }
  end
end
