# frozen_string_literal: true

RSpec.describe Banzai::Filter, 'subclass' do
  # A simple Filter implementation for testing
  class Yell < Banzai::Filter
    def call(input)
      input.to_s.upcase + '!' * level
    end

    def level
      options[:level] || 1
    end
  end

  subject { Yell }
  let(:input) { 'chunky bacon' }

  describe '.call' do
    it 'filters the input' do
      expect(subject.call(input)).to eq 'CHUNKY BACON!'
    end
  end

  describe '#call' do
    it 'filters the input using options' do
      expect(subject.new(level: 3).call(input)).to eq 'CHUNKY BACON!!!'
    end
  end
end
