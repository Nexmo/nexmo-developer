module Feedback
  class Feedback < ApplicationRecord
    scope :created_after, ->(date) { where('feedback_feedbacks.created_at >= ?', date) if date.present? }
    scope :created_before, ->(date) { where('feedback_feedbacks.created_at <= ?', date) if date.present? }
    scope :created_between, ->(start_date, end_date) { created_after(start_date).created_before(end_date) }

    belongs_to :resource, class_name: '::Feedback::Resource'
    belongs_to :owner, polymorphic: true
    belongs_to :config, optional: true, class_name: '::Feedback::Config', foreign_key: 'feedback_config_id', inverse_of: :feedbacks

    attr_accessor :email, :source

    before_validation :set_resource

    validates :sentiment, presence: true
    validates :owner, presence: true

    scope :positive, -> { where(sentiment: 'positive') }
    scope :negative, -> { where(sentiment: 'negative') }
    scope :neutral,  -> { where(sentiment: 'neutral') }

    after_commit :notify

    def set_resource
      self.resource ||= Resource.find_or_create_by!(uri: source)
    end

    def notify
      return unless ENV['SLACK_WEBHOOK']

      FeedbackSlackNotifier.call(self)
    end
  end
end
