require 'rails_helper'

RSpec.describe Greenhouse do
  let(:client) { instance_double(GreenhouseIo::JobBoard) }

  subject { described_class.new }

  describe '#jobs' do
    context 'When the cache is empty' do
      it 'fetches the jobs from Greenhouse\'s API' do
        expect(GreenhouseIo::JobBoard).to receive(:new).and_return(client)
        expect(client).to receive(:jobs).with(content: 'true').and_return({ jobs: [] })

        subject.jobs
      end
    end

    context 'When it is not' do
      let(:cache) { ActiveSupport::Cache::MemoryStore.new }

      before do
        expect(Rails).to receive(:cache).and_return(cache)
        cache.write('careers', { jobs: [] })
      end

      it 'fetches the jobs from the cache' do
        expect(subject.jobs).to eq(jobs: [])
      end
    end
  end

  describe '#devrel_careers' do
    let(:devrel_position) do
      { title: 'OpenTok Advocate - Remote', departments: [{ id: described_class::DEPARTMENT_ID }] }
    end

    let(:open_positions) do
      [
        devrel_position,
        { title: 'OpenTok - Remote', departments: [{ id: described_class::DEPARTMENT_ID }] },
      ]
    end

    it 'returns the positions that belong to our department and team' do
      expect(GreenhouseIo::JobBoard).to receive(:new).and_return(client)
      expect(client).to receive(:jobs).with(content: 'true').and_return({ jobs: open_positions })

      devrel_positions = described_class.devrel_careers
      expect(devrel_positions.size).to eq(1)
      expect(devrel_positions.first.title).to eq(devrel_position[:title])
    end
  end

  describe '.expire_cache' do
    it 'expires the careers from the cache' do
      expect(Rails.cache).to receive(:delete).with('careers')
      described_class.expire_cache
    end
  end
end
