namespace :screenshots do
  desc 'Update all automated screenshots'
  task all: :environment do
    Screenshot.update_all
  end

  desc 'Create new screenshots'
  task new: :environment do
    Screenshot.update_new
  end
end
