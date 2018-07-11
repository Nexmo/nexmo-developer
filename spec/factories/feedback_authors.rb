FactoryBot.define do
  factory :feedback_author, class: 'Feedback::Author' do
    email { Faker::Internet.safe_email }
  end
end
