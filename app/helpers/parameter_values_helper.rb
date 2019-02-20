module ParameterValuesHelper
  def parameter_values(enum)
    to_sentence(enum.map { |value| content_tag(:code, value) }, last_word_connector: ' or ', two_words_connector: ' or ')
  end
end
