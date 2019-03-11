module AdminApi
  class BuildingBlocksController < AdminApiController
    respond_to :json

    def index
    #   return unless authenticate
      @events = UsageBuildingBlockEvent.all.group(:block, :language, :section, :action).count(:action)

      if params[:created_after] || params[:created_before]
        if params[:block] && params[:language]
          @events = UsageBuildingBlockEvent.created_between(params[:created_after], params[:created_before]).where('block = ? and language = ?', params[:block], params[:language]).group(:block, :language, :section, :action).count(:action)
        elsif params[:block]
          @events = UsageBuildingBlockEvent.created_between(params[:created_after], params[:created_before]).where('block = ?', params[:block]).group(:block, :language, :section, :action).count(:action)
        elsif params[:language]
          @events = UsageBuildingBlockEvent.created_between(params[:created_after], params[:created_before]).where('language = ?', params[:language]).group(:block, :language, :section, :action).count(:action)
        else
          @events = UsageBuildingBlockEvent.created_between(params[:created_after], params[:created_before]).group(:block, :language, :section, :action).count(:action)
        end
      elsif params[:language] && params[:block]
        @events = UsageBuildingBlockEvent.where('block = ? and language = ?', params[:block], params[:language]).group(:block, :language, :section, :action).count(:action)
      elsif params[:language]
        @events = UsageBuildingBlockEvent.where('language = ?', params[:language]).group(:block, :language, :section, :action).count(:action)
      elsif params[:block]
        @events = UsageBuildingBlockEvent.where('block = ?', params[:block]).group(:block, :language, :section, :action).count(:action)
      end

      render 'index'
    end
  end
end
