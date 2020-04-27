class Product
  # TODO: return instances
  def self.all
    [
      { 'path' => 'messaging/sms', 'icon' => 'message', 'icon_colour' => 'purple', 'name' => 'SMS' },
      { 'path' => 'voice/voice-api', 'icon' => 'phone', 'icon_colour' => 'green', 'name' => 'Voice' },
      { 'path' => 'verify', 'icon' => 'lock', 'icon_colour' => 'purple-dark', 'name' => 'Verify' },
      { 'path' => 'messages', 'icon' => 'chat', 'icon_colour' => 'blue', 'name' => 'Messages' },
      { 'path' => 'dispatch', 'icon' => 'flow', 'icon_colour' => 'blue', 'name' => 'Dispatch' },
      { 'path' => 'number-insight', 'icon' => 'file-search', 'icon_colour' => 'orange', 'name' => 'Number Insight' },
      { 'path' => 'conversation', 'icon' => 'message', 'icon_colour' => 'blue', 'name' => 'Conversation' },
      { 'path' => 'client-sdk', 'icon' => 'queue', 'icon_colour' => 'blue', 'name' => 'Client SDK' },
      { 'path' => 'account/subaccounts', 'icon' => 'user', 'icon_colour' => 'blue', 'name' => 'Subaccounts' },
    ]
  end

  def self.normalize_title(product)
    return 'SMS' if product == 'messaging/sms'
    return 'Voice' if product == 'voice/voice-api'
    return 'Number Insight' if product == 'number-insight'
    return 'Messages' if product == 'messages'
    return 'Dispatch' if product == 'dispatch'
    return 'Client SDK' if product == 'client-sdk'
    return 'Subaccounts' if product == 'account/subaccounts'

    product.camelcase
  end
end
