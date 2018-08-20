class MarkdownFilter < Banzai::Filter
  def call(input)
    markdown.render(input)
  end

  private

  def renderer
    @renderer ||= HTML.new
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer, {
      no_intra_emphasis: true,
      tables: true,
      strikethrough: true,
      superscript: true,
      underline: true,
      highlight: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      start_inline: true,
    })
  end
end
