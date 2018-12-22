namespace :ci do
  desc 'Verify all pages to make sure that no exceptions are thrown'
  task 'verify_pages': :environment do
    document_paths =
      [
        "#{Rails.root}/_documentation/**/*.md",
        "#{Rails.root}/_api/**/*.md",
        "#{Rails.root}/_tutorials/**/*.md",
      ]
    document_paths.each do |path|
      Dir.glob(path).each do |filename|
        document = File.read(filename)
        MarkdownPipeline.new.call(document)
      end
    end
  end

  desc 'Verify side navigation to make sure every page has valid YAML metadata'
  task 'verify_navigation': :environment do
    session = ActionDispatch::Integration::Session.new(Rails.application)
    res = session.get '/documentation'
    raise 'Error rendering documentation index page' if res == 500
  end

  desc 'Render all OAS based API references'
  task 'verify_oas_reference': :environment do
    session = ActionDispatch::Integration::Session.new(Rails.application)
    OpenApiConstraint.list.each do |name|
      res = session.get "/api/#{name}"
      raise "Error rendering /api/#{name} OAS page" if res == 500
    end
  end
end
