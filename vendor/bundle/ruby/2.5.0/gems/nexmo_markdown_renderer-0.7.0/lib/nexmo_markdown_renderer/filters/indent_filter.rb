module Nexmo
  module Markdown
    class IndentFilter < Banzai::Filter
      def call(input)
        input.gsub(/^^\s{4}\-\>\s(.+?)$/) do
          body = Nexmo::Markdown::Renderer.new.call($1)
          <<~HEREDOC
            <div class="indent">
              #{body}
            </div>
          HEREDOC
        end
      end
    end
    
  end
end