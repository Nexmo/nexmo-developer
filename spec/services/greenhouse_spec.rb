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

  describe '#valid_job?' do
    it 'returns true if the job is from our department and team' do
      job = { title: 'OpenTok Advocate - Remote', departments: [{ id: described_class::DEPARTMENT_ID }] }
      expect(described_class.new.valid_job?(job)).to be_truthy
    end

    it 'returns false otherwise' do
      job = { title: 'OpenTok - Remote', departments: [{ id: described_class::DEPARTMENT_ID }] }
      expect(described_class.new.valid_job?(job)).to be_falsey
    end
  end

  describe '.expire_cache' do
    it 'expires the careers from the cache' do
      expect(Rails.cache).to receive(:delete).with('careers')
      described_class.expire_cache
    end
  end
end
