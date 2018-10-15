class ColumnsFilter < Banzai::Filter
  def call(input)
    input.gsub!(%r{{column\:([1-4])\/([1-4])}\n(.+?){end}}m) do
      s = []
      s << row_start if $1 == '1'
      s << column_start($2)
      s << $3
      s << column_end
      s << row_end if $1 == $2
      s.join('')
    end

    input
  end

  private

  def row_start
    "FREEZESTART#{Base64.urlsafe_encode64('<div class="row">')}FREEZEEND\n"
  end

  def row_end
    close_tag
  end

  def close_tag
    "FREEZESTART#{Base64.urlsafe_encode64('</div>')}FREEZEEND"
  end

  def column_start(columns)
    html = "<div class='column small-12 medium-#{part_size(columns)}'>"
    "FREEZESTART#{Base64.urlsafe_encode64(html)}FREEZEEND\n"
  end

  def column_end
    "FREEZESTART#{Base64.urlsafe_encode64('</div>')}FREEZEEND\n"
  end

  def part_size(columns)
    12 / Integer(columns)
  end
end
