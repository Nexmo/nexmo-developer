class CodeLanguage
  include ActiveModel::Model
  attr_accessor :key, :label, :type, :dependencies, :unindent, :icon, :run_command
  attr_writer :weight, :linkable, :languages, :lexer

  def weight
    @weight || 999
  end

  def linkable?
    @linkable || true
  end

  def lexer
    return Rouge::Lexers::PHP.new({ start_inline: true }) if @lexer == 'php'
    Rouge::Lexer.find(@lexer) || Rouge::Lexer.find('text')
  end

  def languages
    @languages.map do |language|
      CodeLanguageResolver.find(language)
    end
  end
end
