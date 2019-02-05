class DocumentationConstraint
  def self.documentation
    code_language.merge(product)
  end

  def self.code_language_list
    CodeLanguageResolver.linkable.map(&:key)
  end

  def self.code_language
    { code_language: Regexp.new(code_language_list.compact.join('|')) }
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
      'messaging/sns',
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
    ]
  end

  def self.product_with_parent
    { product: Regexp.new(product_with_parent_list.compact.join('|')) }
  end
end
