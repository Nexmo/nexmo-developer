class BreakFilter < Banzai::Filter
  def call(input)
    input.gsub('§', '<br>')
  end
end
