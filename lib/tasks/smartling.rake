namespace :smartling do
  desc 'Update a translation file for a given locale'
  task :update_translation, %i[file locale] => [:environment] do |_, args|
    smartling = SmartlingAPI.new(
      user_id: ENV['SMARTLING_USER_ID'],
      user_secret: ENV['SMARTLING_USER_SECRET'],
      project_id: ENV['SMARTLING_PROJECT_ID']
    )

    puts 'Updating the file...'
    smartling.download_translated(filename: args[:file], locale: args[:locale])
    puts 'Done!'
  end

  desc 'Upload a file'
  task :upload_file, %i[file locale] => [:environment] do |_, args|
    # be rake "smartling:upload_file[_documentation/en/messages/overview.md,en]"
    smartling = SmartlingAPI.new(
      user_id: ENV['SMARTLING_USER_ID'],
      user_secret: ENV['SMARTLING_USER_SECRET'],
      project_id: ENV['SMARTLING_PROJECT_ID']
    )

    puts 'Uploading the file...'
    smartling.upload(args[:file])
    puts 'Done!'
  end

  desc 'Downloading a translation for a given locale'
  task :download_translation, %i[file locale type] => [:environment] do |_, args|
    # be rake "smartling:download_translation[_documentation/en/messages/overview.md,en-US,pseudo]"
    smartling = SmartlingAPI.new(
      user_id: ENV['SMARTLING_USER_ID'],
      user_secret: ENV['SMARTLING_USER_SECRET'],
      project_id: ENV['SMARTLING_PROJECT_ID']
    )

    puts 'Downloading the translation...'
    smartling.download_translated(filename: args[:file], locale: args[:locale], type: args[:type])
    puts 'Done!'
  end

  desc 'Find documents that need translations'
  task translations_due: :env do
  end
end
