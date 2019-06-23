module Usage
  class AbResultController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      ab_finished(params['t'].to_sym)
    end
  end
end
