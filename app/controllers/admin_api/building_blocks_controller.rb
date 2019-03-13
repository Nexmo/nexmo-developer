module AdminApi
  class BuildingBlocksController < AdminApiController
    respond_to :json

    def index
      return unless authenticate
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
      @events = organize_data(@events)
      byebug
      render 'index'
    end

    private

    def organize_data(events)
      events_new = []
      block = ''
      language = ''
      section = ''
      actions = []
      first_time = true
      events.each do |event|
        if event[0][0] != block || event[0][1] != language || event[0][2] != section
          if first_time == false
            events_new << [block, language, section]
            events_new[0].push(actions)
          end
          block = event[0][0]
          language = event[0][1]
          section = event[0][2]
          actions = []
        end
        actions.push(["#{event[0][3]}: #{event[1][0]}"])
        events_new
        first_time = false
      end
      events_new << [block, language, section]
      if !events_new[3].kind_of?(Array)
        events_new.push(actions)
      end
      events_new
    end
  end
end
