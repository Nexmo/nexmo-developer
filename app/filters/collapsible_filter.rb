class CollapsibleFilter < Banzai::Filter
  def call(input)
    input.gsub(/^\|\s(\#{1,6})(\s)?(.+?)\n^\|\n(.+?)\n\n/m) do |_s|
      heading_type = "h#{$1.length}"
      heading = $3
      body = $4.gsub(/^\|\n/, "\n")
      body = body.gsub(/^\|\s/, '')
      parsed_body = MarkdownPipeline.new.call(body)

      id = SecureRandom.hex

      <<~HEREDOC
        <#{heading_type} class="collapsible">
          <a class="js-collapsible" data-collapsible-id=#{id}>
            #{heading}
          </a>
        </#{heading_type}>

        <div id="#{id}" class="collapsible-content" style="display: none;">
          #{parsed_body}
        </div>

      HEREDOC
    end
  end
end
