module Nexmo
  module Markdown
    class ModalFilter < Banzai::Filter
      def call(input)
        modals = []
    
        input.gsub!(/@\[(.+?)\]\((.+?)\)/) do |_s|
          id = 'M' + SecureRandom.hex(12)
          modals << { document: $2, id: id }
          "<a href='javascript:void(0)' data-modal='#{id}' class='Vlt-modal-trigger Vlt-text-link'>#{$1}</a>"
        end
    
        modals = modals.map do |modal|
          filename = "#{Nexmo::Markdown::Config.docs_base_path}/#{modal[:document]}"
          raise "Could not find modal #{filename}" unless File.exist? filename
    
          document = File.read(filename)
          output = Nexmo::Markdown::Renderer.new.call(document)
    
          modal = <<~HEREDOC
            <div class="Vlt-modal" id="#{modal[:id]}">
              <div class="Vlt-modal__panel">
                <div class="Vlt-modal__content">
              #{output}
                </div>
              </div>
            </div>
          HEREDOC
    
          "FREEZESTART#{Base64.urlsafe_encode64(modal)}FREEZEEND"
        end
    
        input + modals.join("\n")
      end
    end
  end
end
