FactoryBot.define do
  factory :feedback_feedback, class: 'Feedback::Feedback' do
    sentiment { 'positive' }
    comment { 'Some feedback text' }
    source { 'https://developer.nexmo.com/some/path' }
    ip { Faker::Internet.ip_v4_address }
    association :owner, factory: :user
  end
end
