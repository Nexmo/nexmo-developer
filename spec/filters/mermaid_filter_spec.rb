require 'rails_helper'

RSpec.describe MermaidFilter do
  it 'formats text starting with ```mermaid`' do
    input = <<~HEREDOC
      ```mermaid
      sequenceDiagram
      User -> Server: Testing
      ```
    HEREDOC

    expected_output = "FREEZESTARTPGRpdiBjbGFzcz0ibWVybWFpZCIgc3R5bGU9ImNvbG9yOiB0cmFuc3BhcmVudDsiPiBzZXF1ZW5jZURpYWdyYW0KVXNlciAtPiBTZXJ2ZXI6IFRlc3RpbmcKPC9kaXY-Cg==FREEZEEND\n"

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'ignores text that does not start with ```mermaid' do
    input = <<~HEREDOC
      some text here
    HEREDOC

    expected_output = "some text here\n"

    expect(described_class.call(input)). to eq(expected_output)
  end

  it 'formats text starting with the helper ```sequence_diagram`' do
    input = <<~HEREDOC
      ```sequence_diagram
      User -> Server: Testing
      ```
    HEREDOC

    expected_output = "FREEZESTARTPGRpdiBjbGFzcz0ibWVybWFpZCIgc3R5bGU9ImNvbG9yOiB0cmFuc3BhcmVudDsiPnNlcXVlbmNlRGlhZ3JhbSBVc2VyIC0-IFNlcnZlcjogVGVzdGluZwo8L2Rpdj4KFREEZEEND\n"

    expect(described_class.call(input)).to eq(expected_output)
  end
end
