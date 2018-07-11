class AddProductToFeedbackResources < ActiveRecord::Migration[5.1]
  def up
    add_column :feedback_resources, :product, :string
    add_index :feedback_resources, :product

    products = [
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

    Feedback::Resource.all.each do |feedback_resource|
      uri = URI(feedback_resource.uri)

      product = products.detect do |product|
        break product if uri.path.start_with? "/#{product}"
      end

      next unless product

      feedback_resource.update({
        product: product,
      })
    end
  end

  def down
    remove_column :feedback_resources, :product
  end
end
