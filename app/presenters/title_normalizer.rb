class TitleNormalizer
  def self.call(folder)
    new(folder).normalize
  end

  def initialize(folder)
    @folder = folder
  end

  def normalize
    if @folder[:is_task?] || @folder[:is_tabbed?]
      @folder[:title]
    elsif @folder[:is_file?]
      frontmatter['navigation'] || frontmatter['title']
    else
      I18n.t("menu.#{@folder[:title]}")
    end
  end

  private

  def frontmatter
    @frontmatter ||= YAML.load_file(@folder[:path])
  end
end
