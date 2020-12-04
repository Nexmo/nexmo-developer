namespace :careers do
  desc 'Expire careers cache'
  task 'expire_cache': :environment do
    p 'Expiring cache...'
    Greenhouse.expire_cache
    p 'Done'
  end
end
