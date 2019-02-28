class JsSequenceDiagramFilter < Banzai::Filter
  def call(input)
    input.gsub(/```js_sequence_diagram(.+?)```/m) do |_s|
      diagram = <<~HEREDOC
        <div class="js-diagram">
          #{$1}
        </div>
      HEREDOC

      "FREEZESTART#{Base64.urlsafe_encode64(diagram)}FREEZEEND"
    end
  end
end
