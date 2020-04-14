class Language
  def self.all
    @all ||= begin
               excluded_languages = ['csharp', 'javascript', 'kotlin', 'android', 'swift', 'objective_c']
               Nexmo::Markdown::CodeLanguage.languages.reject { |l| excluded_languages.include?(l.key) }
             end
  end
end
