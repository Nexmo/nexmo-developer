namespace :documentation do
  desc 'Verify all pages have meta_title and description keys'
  task 'check_keys': :environment do
    documentation_path = "#{Rails.root}/_documentation/**/*.md"
    documents = []

    Dir.glob(documentation_path).each do |filename|
      document = YAML.safe_load(File.read(filename))
      meta_title = document['meta_title']
      description = document['description']
      if meta_title.blank? || description.blank?
        documents.push(filename.split('/_documentation')[1])
      end
    end
    count = documents.count
    raise "The following #{count} documents are missing either a 'meta_title' or 'description' key:\n#{documents.join("\n")}" if count.positive?
  end
end
