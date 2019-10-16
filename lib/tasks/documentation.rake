namespace :documentation do
  desc 'Verify all pages have meta_title and description keys'
  task 'check_keys': :environment do
    documentation_path = "#{Rails.root}/_documentation/**/*.md"
    documents = []

    Dir.glob(documentation_path).each do |filename|
      document = YAML.safe_load(File.read(filename))

      if !document.key?('meta_title') == false || !document.key?('description') == false
        documents.push(filename.split('/_documentation')[1])
      end
    end
    puts "The following #{documents.count} documents are missing either a 'meta_title' or 'description' key:\n#{documents.join("\n")}"
  end
end
