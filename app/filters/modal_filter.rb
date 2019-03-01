class ModalFilter < Banzai::Filter
  def call(input)
    modals = []

    input.gsub!(/@\[(.+?)\]\((.+?)\)/) do |_s|
      uuid = SecureRandom.uuid
      modals << { document: $2, uuid: uuid }
      "<a data-open='#{uuid}'>#{$1}</a>"
    end

    modals = modals.map do |modal|
      filename = "#{Rails.root}/#{modal[:document]}"
      raise "Could not find modal #{filename}" unless File.exist? filename

      document = File.read(filename)
      output = MarkdownPipeline.new.call(document)

      modal = <<~HEREDOC
        <div class="reveal" id="#{modal[:uuid]}" data-reveal>
          #{output}
        </div>
      HEREDOC

      "FREEZESTART#{Base64.urlsafe_encode64(modal)}FREEZEEND"
    end

    input + modals.join("\n")
  end
end
