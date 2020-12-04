module Nexmo
  module Markdown
    class PartialFilter < Banzai::Filter
      def call(input)
        input.gsub(/```partial(.+?)```/m) do |_s|
          config = YAML.safe_load($1)
          file_path = if config['source'].starts_with? 'app/views'
                        "#{Rails.root}/#{config['source']}"
                      else
                        "#{Nexmo::Markdown::Config.docs_base_path}/#{config['source']}"
                      end
          content = File.read(file_path)
    
          active = options[:code_language] ? options[:code_language].key == config['platform'] : false
    
          if config['platform']
            <<~HEREDOC
              <div class="js-platform" data-platform="#{config['platform']}" data-active="#{active}">
                #{content.render_markdown}
              </div>
            HEREDOC
          else
            content
          end
        end
      end
    end
  end
end
