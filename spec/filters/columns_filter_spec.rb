require 'rails_helper'

RSpec.describe ColumnsFilter do
  it 'wraps content into columns' do
    input = <<~HEREDOC
      {column:1/2}
      Column A
      {end}
      {column:2/2}
      Column B
      {end}
    HEREDOC

    output = described_class.call(input)

    expect(output).to eq(
      <<~HEREDOC
        FREEZESTARTPGRpdiBjbGFzcz0icm93Ij4=FREEZEEND
        FREEZESTARTPGRpdiBjbGFzcz0nY29sdW1uIHNtYWxsLTEyIG1lZGl1bS02Jz4=FREEZEEND
        Column A
        FREEZESTARTPC9kaXY-FREEZEEND

        FREEZESTARTPGRpdiBjbGFzcz0nY29sdW1uIHNtYWxsLTEyIG1lZGl1bS02Jz4=FREEZEEND
        Column B
        FREEZESTARTPC9kaXY-FREEZEEND
        FREEZESTARTPC9kaXY-FREEZEEND
      HEREDOC
    )
  end
end
