class String
  def render_markdown
    MarkdownPipeline.new.call(self).html_safe
  end

  def unindent
    indent = squeeze("\n").lines.map { |line| line.index(/[^\s]/) }.compact.min || 0
    gsub(/^[[:blank:]]{#{indent}}/, '')
  end

  def unindent!
    replace(unindent)
  end
end
