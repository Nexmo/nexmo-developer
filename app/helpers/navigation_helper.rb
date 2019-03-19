HEADING_TAG_DEPTHS = {
  'h0' => 0,
  'h1' => 1,
  'h2' => 2,
  'h3' => 3,
  'h4' => 4,
  'h5' => 5,
  'h6' => 6,
}.freeze

module NavigationHelper
  def navigation_from_content(content:, title: nil)
    content = "<h0 class='injected'>#{title}</h0>\n" + content if title
    document = build_document(content)

    nodes = ['<ul class="Vlt-sidemenu Vlt-sidemenu--rounded Vlt-sidemenu--flat navigation js-navigation">']
    last_node = nil

    document.css('.reveal').remove

    document.css('h0,h2,h3,h4,h5,h6').each do |heading|
      # If it's a header within tabbed content (including Code Snippets) we don't want to treat
      # the header as a navigation item in the sidebar
      next unless heading.ancestors('.tabs-content').empty?
      next unless heading.ancestors('.Vlt-tabs').empty?

      # Same with callouts
      next unless heading.ancestors('.Vlt-callout').empty?

      if last_node.nil? || heading.name == last_node.name
        # Do nothing (cleaner than adding wrapping further conditions)
      elsif heading.name >= last_node.name # e.g. h2 -> h3
        nodes << '<ul>'
      else # e.g. h4 -> h2
        (HEADING_TAG_DEPTHS[last_node.name] - HEADING_TAG_DEPTHS[heading.name]).times do
          nodes << '</li></ul>'
        end
      end

      nodes << <<~HEREDOC
        <li>
          <a class="Vlt-sidemenu__link" href="##{heading.attributes['id']}" data-scrollspy-id="#{heading['data-id']}">
            #{heading.text}
          </a>
      HEREDOC
      last_node = heading
    end
    nodes << '</li></ul>'
    nodes.join("\n").html_safe
  end

  private

  def build_document(content)
    Nokogiri::HTML::DocumentFragment.parse(content)
  end
end
