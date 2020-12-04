module Translator
  module Smartling
    class TokenGenerator
      def self.client
        @client ||= ::Smartling::Api.new(
          userId: ENV['SMARTLING_USER_ID'],
          userSecret: ENV['SMARTLING_USER_SECRET']
        )
      end

      def self.token
        @token ||= client.token
      end
    end
  end
end
