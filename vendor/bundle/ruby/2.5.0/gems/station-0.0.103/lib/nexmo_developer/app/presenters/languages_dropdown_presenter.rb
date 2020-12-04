class LanguagesDropdownPresenter
  class Option
    def initialize(language)
      @language = language
    end

    def code_language
      @code_language ||= @language.key
    end
  end

  def options
    @options ||= languages.map { |l| Option.new(l) }
  end

  def languages
    @languages ||= Nexmo::Markdown::CodeLanguage.languages.reject { |l| l.key == 'dotnet' }
  end
end
