class TopnavItem
  attr_reader :url

  def initialize(name, url, navigation)
    @name       = name
    @url        = url
    @navigation = navigation.to_s
  end

  def title
    @title ||= I18n.t("layouts.partials.header.#{@name.downcase}")
  end

  def css_classes
    classes = ['Vlt-tabs__link']
    classes << 'Vlt-tabs__link_active' if @navigation == @name.downcase
    classes.join(' ')
  end
end
