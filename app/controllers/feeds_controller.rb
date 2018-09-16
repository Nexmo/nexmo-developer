require 'icalendar'

class FeedsController < ApplicationController
  def events
    calendar = Icalendar::Calendar.new
    calendar.x_wr_calname = 'Nexmo Developer Events'

    Event.all.each do |event|
      calendar.event do |e|
        e.dtstart = Icalendar::Values::Date.new(event.starts_at)
        e.dtend = Icalendar::Values::Date.new(event.ends_at + 1.day)
        e.summary = event.title
        e.description = event.description
      end
    end

    calendar.publish
    render plain: calendar.to_ical
  end
end
