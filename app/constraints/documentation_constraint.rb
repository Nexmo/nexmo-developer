class DocumentationConstraint
  def self.exists?(request, constraints)
    if request.parameters[:code_language]
      if File.exist? "#{namespace_path(request)}/#{request.parameters[:document]}/#{request.parameters[:code_language]}.md"
        request.parameters[:document] += "/#{request.parameters[:code_language]}"
        request.parameters.delete(:code_language)
      end
    end

    self.send(constraints).each do |key, value|
      next unless request.parameters[key]
      return false unless value.match?(request.parameters[key])
    end

    true
  end

  def self.namespace_path(request)
    if request.parameters[:namespace].present?
      namespace_path = "app/views/#{request.parameters[:namespace]}"
    elsif request.path.start_with? '/api/'
      namespace_path = "_api/"
    else
      namespace_path = "_documentation/#{request.parameters[:product]}"
    end
  end

  def self.documentation
    code_language.merge(product)
  end

  def self.code_language
    linkable_languages = CodeLanguageResolver.linkable.map(&:key)
    { code_language: Regexp.new(linkable_languages.compact.join('|')) }
  end

  def self.product_list
    [
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
