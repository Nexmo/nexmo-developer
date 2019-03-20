require 'rails_helper'

RSpec.describe Feedback::Feedback, type: :model do
  let(:date) { Date.new(2019, 3, 1) }

  describe '.created_between' do
    context 'with a start_date' do
      let(:start_date) { date }
      let(:end_date) { nil }

      it 'excludes feedbacks created before start_date' do
        FactoryBot.create(:feedback_feedback, created_at: date - 1)

        feedbacks = described_class.created_between(start_date, end_date)

        expect(feedbacks).to be_empty
      end
    end

    context 'with an end_date' do
      let(:start_date) { nil }
      let(:end_date) { date }

      it 'excludes feedbacks created after end_date' do
        FactoryBot.create(:feedback_feedback, created_at: date + 1)

        feedbacks = described_class.created_between(start_date, end_date)

        expect(feedbacks).to be_empty
      end
    end
  end
end
