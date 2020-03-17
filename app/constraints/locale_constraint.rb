class LocaleConstraint
  def initialize
    @locales = I18n.available_locales.map(&:to_s)
  end

  def matches?(request)
    if request.params['locale']
      @locales.include?(request.params['locale'])
    else
      true
    end
  end

  def self.available_locales
    /#{I18n.available_locales.join('|')}/
  end
end
