require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe '#all' do
    it 'returns an array of Tutorials' do
      tutorials = Tutorial.all
      expect(tutorials.class).to eq(Array)
      expect(tutorials[0].class).to eq(Tutorial)
    end
  end

  describe '#by_product' do
    it 'returns only tutorials for the specified product type' do
      tutorials = Tutorial.by_product('messaging/sms')
      expect(tutorials.class).to eq(Array)
      expect(tutorials[0].class).to eq(Tutorial)

      tutorials.each do |tutorial|
        expect(tutorial.products).to include('messaging/sms')
      end
    end

    it 'returns an empty array when given an invalid product' do
      tutorials = Tutorial.by_product('some_invalid_product')
      expect(tutorials).to eq([])
    end
  end

  describe '.by_language' do
    it 'returns only tutorials for the specified language' do
      tutorials = Tutorial.by_language('Ruby')
      expect(tutorials).to be_a(Array)
      expect(tutorials).not_to be_empty

      tutorials.each do |tutorial|
        expect(tutorial.languages).to include('Ruby')
      end
    end
  end

  describe '#body' do
    it 'returns a string' do
      expect(Tutorial.all[0].body.class).to eq(String)
    end
  end

  describe '#path' do
    it 'returns a path' do
      expect(Tutorial.all[0].path).to start_with('/tutorials/')
    end
  end
end
