module Usage
  class CodeSnippetController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      event = ::Usage::CodeSnippetEvent.new(
        language: params['language'],
        snippet: params['snippet'],
        action: params['event'],
        section: params['section'],
        ip: request.remote_ip
      )

      event.save!

      render json: event
    end
  end
end
