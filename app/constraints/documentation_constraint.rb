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
      'stitch',
      'messages-and-workflows-apis',
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
      'stitch/in-app-voice',
      'stitch/in-app-messaging',
      'messages-and-workflows-apis/messages',
      'messages-and-workflows-apis/workflows',
    ]
  end

  def self.product_with_parent
    { product: Regexp.new(product_with_parent_list.compact.join('|')) }
  end

  def self.language_configuration
    @language_configuration ||= YAML.load_file("#{Rails.root}/config/code_languages.yml")
  end
end
