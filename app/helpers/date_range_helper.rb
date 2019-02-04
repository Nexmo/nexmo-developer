module DateRangeHelper
  def date_range(start_date, end_date)
    starts = start_date.strftime('%-d %B %Y')
    ends = end_date.strftime('%-d %B %Y')
    return starts if start_date == end_date
    "#{starts} - #{ends}"
  end
end
