module Modules
  module Messaging
    class SmsController < ApplicationController
      include Wicked::Wizard

      layout 'iframe'
      steps :outbound, :inbound, :summary

      def show
        case step
        when :inbound
          @uuid = params[:uuid]
          @number = JSON.parse(
            redis.get("Modules::Messaging::Sms::uuid(#{@uuid})")
          )['number']
        end
        render_wizard
      end

      def update
        case step
        when :outbound
          if params[:number]
            nexmo.send_message({
              from: ENV['NEXMO_FROM_NUMBER'],
              to: params[:number],
              text: 'A demo SMS sent from Nexmo Developer',
            })

            uuid = SecureRandom.uuid
            redis.set("Modules::Messaging::Sms::number(#{params[:number]})", uuid)
            redis.set("Modules::Messaging::Sms::uuid(#{uuid})", {
              number: params[:number],
            }.to_json)
            jump_to(:inbound, uuid: uuid)
          end
        end

        render_wizard
      end

      def webhook
        if params[:msisdn]
          uuid = redis.get("Modules::Messaging::Sms::number(#{params[:msisdn]})")

          if uuid
            pusher.trigger("modules_messaging_sms_uuid_#{uuid}", 'inbound_sms', {
              text: params[:text],
            })
          end
        end

        head :ok
      end

      private

      def redis
        if ENV['REDIS_URL']
          @redis ||= Redis.new(url: ENV['REDIS_URL'])
        else
          @redis ||= Redis.new
        end
      end

      def nexmo
        @nexmo ||= Nexmo::Client.new({
          key: ENV['NEXMO_API_KEY'],
          secret: ENV['NEXMO_API_SECRET'],
        })
      end

      def pusher
        @pusher ||= Pusher::Client.new(
          app_id: ENV['PUSHER_APP_ID'],
          key: ENV['PUSHER_KEY'],
          secret: ENV['PUSHER_SECRET'],
          cluster: 'eu',
          encrypted: true
        )
      end
    end
  end
end
