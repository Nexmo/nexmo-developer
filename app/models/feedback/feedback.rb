module Feedback
  class Feedback < ApplicationRecord
    scope :created_after, ->(date) { where('feedback_feedbacks.created_at >= ?', date) if date.present? }
    scope :created_before, ->(date) { where('feedback_feedbacks.created_at <= ?', date) if date.present? }
    scope :created_between, ->(start_date, end_date) { created_after(start_date).created_before(end_date) }

    belongs_to :resource, class_name: '::Feedback::Resource'
    belongs_to :owner, polymorphic: true

    attr_accessor :email, :source
    before_validation :set_resource

    validates :sentiment, presence: true
    validates :owner, presence: true

    scope :positive, -> { where(sentiment: 'positive') }
    scope :negative, -> { where(sentiment: 'negative') }

    after_commit :notify

    private

    def emoji
      case sentiment
      when 'negative' then ':-1:'
      when 'positive' then ':+1:'
      else ':neutral_face:'
      end
    end

    def set_resource
      self.resource ||= Resource.find_or_create_by!(uri: source)
    end

    def notify
      notify_slack
    end

    def slack_color
      case sentiment
      when 'negative' then 'danger'
      when 'positive' then 'good'
      else '#ccc'
      end
    end

    def state
      created_at == updated_at ? 'New' : 'Updated'
    end

    def notify_slack
      return unless ENV['SLACK_WEBHOOK']

      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK'], username: 'feedbot'
      admin_url = "#{ENV['FEEDBOT_PROTOCOL']}://#{ENV['FEEDBOT_HOST']}/admin/feedbacks/#{id}"

      options = {
        attachments: [
          {
            title: "#{emoji} #{state} #{sentiment.upcase_first} feedback",
            title_link: admin_url,
            text: '-',
            color: slack_color,
            fields: [
              {
                  title: ':link: URL',
                  value: resource.uri,
              },
              {
                  title: ':hammer_and_wrench: Nexmo Developer Admin Link',
                  value: admin_url,
              },
            ],
          },
        ],
      }

      if owner.email
        options[:attachments][0][:fields] << {
          title: ':bust_in_silhouette: Author',
          value: owner.email,
        }
      end

      if comment.present?
        options[:attachments][0][:fields] << {
           title: ':speech_balloon: Comment',
           value: comment,
        }
      end

      if code_language
        options[:attachments][0][:fields] << {
          title: ':computer: Code Language',
          value: code_language,
        }
      end

      notifier.post options
    end
  end
end
