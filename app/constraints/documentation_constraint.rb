class DocumentationConstraint
  def self.documentation
    CodeLanguage.route_constraint.merge(product)
  end

  def self.product_list
    [
      'audit',
      'voice',
      'messaging',
      'verify',
      'number-insight',
      'account',
      'concepts',
      'client-sdk',
      'stitch',
      'conversation',
      'messages',
      'dispatch',
      'vonage-business-cloud',
    ]
  end

  def self.product
    { product: Regexp.new(product_list.compact.join('|')) }
  end

  def self.product_with_parent_list
    [
      'audit',
      'voice/sip',
      'voice/voice-api',
      'messaging/sms',
      'messaging/conversion-api',
      'messaging/us-short-codes',
      'verify',
      'number-insight',
      'account',
      'concepts',
      'client-sdk',
      'client-sdk/in-app-voice',
      'client-sdk/in-app-video',
      'client-sdk/in-app-messaging',
      'conversation',
      'messages',
      'dispatch',
      'vonage-business-cloud/number-programmability',
      'vonage-business-cloud/integration-suite',
      'vonage-business-cloud/vbc-apis/account-api',
      'vonage-business-cloud/vbc-apis/extension-api',
      'vonage-business-cloud/vbc-apis/user-api',
      'account/subaccounts',
    ]
  end

  def self.product_with_parent
    { product: Regexp.new(product_with_parent_list.compact.join('|')) }
  end
end
