class LabelFilter < Banzai::Filter
  def call(input)
    return input if options[:disable_label_filter]
    input.gsub(/\s\[([a-zA-Z0-9\s:\-\.]+)\]/) do |_s|
      "<span class='Vlt-badge #{class_name($1)}'>#{$1}</span> "
    end
  end

  private

  def class_name(text)
    case text
    when 'POST'
      'Vlt-badge--green'
    when 'GET'
      'Vlt-badge--blue'
    when 'DELETE'
      'Vlt-badge--red'
    when 'PUT'
      'Vlt-badge--yellow'
    end
  end
end
