class CollapsibleFilter < Banzai::Filter
  def call(input)
    input.gsub(/^\|\s(\#{1,6})(\s)?(.+?)\n^\|\n(.+?)\n\n/m) do |_s|
      heading = $3
      body = $4.gsub(/^\|\n/, "\n")
      body = body.gsub(/^\|\s/, '')
      parsed_body = MarkdownPipeline.new.call(body)

      <<~HEREDOC
        <div class="Vlt-accordion Vlt-box Vlt-box--lesspadding Nxd-accordion-emphasis">
          <h5 class="Vlt-accordion__trigger"  tabindex="0">#{heading}</h5>
          <div class="Vlt-accordion__content Vlt-accordion__content--noborder">
            #{parsed_body}
          </div>
        </div>
      HEREDOC
    end
  end
end
