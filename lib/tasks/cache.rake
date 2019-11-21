namespace :cache do
  desc "Clear Rails' redis cache"
  task 'clear': :environment do
    Rails.cache.clear
  end
end
