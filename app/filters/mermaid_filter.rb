class MermaidFilter < Banzai::Filter
  TYPES = {
    'mermaid' => '',
    'sequence_diagram' => 'sequenceDiagram',
  }.freeze

  def call(input)
    TYPES.each do |markdown, mermaid|
      input = input.gsub(/```#{markdown}(.+?)```/m) do |_s|
        render_mermaid(mermaid, $1)
      end
    end

    input
  end

  def render_mermaid(type, content)
    diagram = <<~HEREDOC
      <div class="mermaid" style="color: transparent;">#{type} #{content.gsub('\\n', '<br />').strip}
      </div>
    HEREDOC

    "FREEZESTART#{Base64.urlsafe_encode64(diagram)}FREEZEEND"
  end
end
