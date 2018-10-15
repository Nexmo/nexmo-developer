OPEN_API_PRODUCTS = %w[
  sms
  media
  number-insight
  stitch
  messages-olympus
  dispatch
  redact
  audit
  voice
  account/secret-management
  external-accounts
].freeze

class OpenApiConstraint
  def self.products
    { definition: Regexp.new(OPEN_API_PRODUCTS.join('|')) }
  end
end
