module AdminApi
  class BuildingBlocksController < AdminApiController
    respond_to :json

    def index
      return unless authenticate

      params.permit!

      if params[:created_after] || params[:created_before]
        @events = UsageBuildingBlockEvent.created_between(params[:created_after], params[:created_before])
      else
        @events = UsageBuildingBlockEvent.all
      end

      query = []
      query.push('block = :block') if params[:block]
      query.push('language = :language') if params[:language]

      unless query.empty?
        @events = @events.where([query.join(' and '), params.to_h])
      end

      @events = @events.group(:block, :language, :section, :action).count(:action)
      @events = organize_data(@events)

      render 'index'
    end

    private

    def organize_data(events)
      output = {}
      events.each do |path, count|
        pointer = output
        path.each do |k|
          leaf_value = (k == path.last) ? count : {}
          pointer[k] = pointer[k] || leaf_value
          pointer = pointer[k]
        end
      end
      output
    end
  end
end
