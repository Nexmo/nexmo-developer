module Nexmo
  module Markdown
    module Concerns
      module PrismCodeSnippet
        include OcticonsHelper

        def code_snippet_body(lexer, body)
          <<~HEREDOC
            <div class="copy-wrapper">
              <div class="copy-button" data-lang="#{code_language_to_prism(lexer.tag)}" data-section="code">
                #{octicon "clippy", :class => 'top left'} <span>#{::I18n.t('code_snippets.copy_to_clipboard') }</span>
              </div>
              <pre class="#{prism_css_classes(lexer)}"><code>#{body}</code></pre>
            </div>
          HEREDOC
        end

        def code_language_to_prism(code_language)
          code_language == 'objective_c' && 'objectivec' || code_language
        end

        def prism_css_classes(lexer)
          code_language = code_language_to_prism(lexer.tag)
          "main-code Vlt-prism--dark language-#{code_language} Vlt-prism--copy-disabled"
        end
      end
    end
  end
end
