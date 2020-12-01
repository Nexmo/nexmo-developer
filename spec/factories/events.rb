FactoryBot.define do
  factory :event do
    title { 'Euruko' }
    url { 'https://euruko.org' }
    starts_at { 3.days.from_now }
    ends_at { 5.days.from_now }
    description { 'The annual European Ruby conference' }
  end

  factory :past_event, class: 'Event' do
    title { 'ForwardJS' }
    url { 'https://forwardjs.com' }
    starts_at { 5.days.ago }
    ends_at { 3.days.ago }
    description { 'JavaScript, web and culture events' }
  end
end
