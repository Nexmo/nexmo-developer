FactoryBot.define do
  factory :user do
    email { 'api.admin@vonage.com' }
    password { 'development' }
  end
end
