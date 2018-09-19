module Usage
  class BuildingBlockController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      event = ::Usage::BuildingBlockEvent.new(
        language: params['language'],
        block: params['block'],
        action: params['event'],
        section: params['section'],
        ip: request.remote_ip
      )

      event.save!

      render json: event
    end
  end
end
