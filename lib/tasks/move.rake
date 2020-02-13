require 'yaml'
desc 'Move content from one location to another. (Be careful with this one)'
task move: :environment do
  ARGV.each { |a| task a.to_sym }

  from = ARGV[1]
  to = ARGV[2]

  raise 'Usage: rake move <from> <to>' unless from && to

  to_dir, = File.split(to)

  # Make sure it starts with _documentation
  documentation_folder = "#{Rails.configuration.docs_base_path}/_documentation/"
  raise "'from' must start with '#{documentation_folder}'" unless from[0..documentation_folder.length - 1] == documentation_folder
  raise "'to' must start with '#{documentation_folder}'" unless to[0..documentation_folder.length - 1] == documentation_folder

  raise "You tried to move files from a location that doesn't exist (#{from})" unless File.exist? from
  raise "You tried to move files to a location that doesn't exist (#{to})" unless File.exist? to_dir
  raise "You tried to move files to a location that already exists (#{to})" if File.exist? to

  # Load up our redirect file
  path = "#{Rails.root}/config/automatic-redirects.yml"
  document = File.read(path)
  redirects = YAML.safe_load(document) || {}

  # Add a top level redirect
  add_redirect(documentation_folder, from, to, redirects)

  # Iterate over every file in there and build up a list
  Dir.glob("#{from}/**/*").each do |filename|
    target = filename.gsub(from, to)
    add_redirect(documentation_folder, filename, target, redirects)
  end

  # Actually move the files
  FileUtils.mv(from, to)

  File.write(path, redirects.to_yaml)
rescue StandardError => e
  puts e
  exit(1)
end

def add_redirect(documentation_folder, from, to, redirects)
  # Strip off the leading _documentation as that never shows in the URL
  from = from.gsub(documentation_folder, '')
  to = to.gsub(documentation_folder, '')

  puts "#{from} => #{to}"

  ext = File.extname(from)
  from = from.gsub(ext, '')
  to = to.gsub(ext, '')

  # Also strip off any file types
  redirects[from] = to
end
