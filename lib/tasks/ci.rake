require './lib/common_errors.rb'

namespace :ci do
  desc 'Verify all pages to make sure that no exceptions are thrown'
  task 'verify_pages': :environment do
    document_paths =
      [
        "#{Rails.configuration.docs_base_path}/_documentation/en/**/*.md",
        "#{Rails.configuration.docs_base_path}/_api/**/*.md",
        "#{Rails.configuration.docs_base_path}/_tutorials/**/*.md",
      ]

    document_paths.each do |path|
      Dir.glob(path).each do |filename|
        document = File.read(filename)
        begin
          Nexmo::Markdown::Renderer.new.call(document)
        rescue StandardError => e
          puts "Error whilst processing #{filename}"
          raise e
        end
      end
    end
  end

  desc 'Verify side navigation to make sure every page has valid YAML metadata'
  task 'verify_navigation': :environment do
    session = ActionDispatch::Integration::Session.new(Rails.application)
    res = session.get '/documentation'

    # Check for migration pending error
    CommonErrors.check_for_migration_error(session.body)

    raise 'Error rendering documentation index page' if res == 500
  end

  desc 'Render all OAS based API references'
  task 'verify_oas_reference': :environment do
    session = ActionDispatch::Integration::Session.new(Rails.application)
    OpenApiConstraint.list.each do |name|
      res = session.get "/api/#{name}"

      # Check for migration pending error
      CommonErrors.check_for_migration_error(session.body)

      raise "Error rendering /api/#{name} OAS page" if res == 500
    end
  end

  desc 'Ensure all OAS error URLS resolve'
  task 'verify_error_urls_resolve': :environment do
    session = ActionDispatch::Integration::Session.new(Rails.application)
    session.host! 'localhost' unless Rails.env.test?

    errors = []

    OpenApiConstraint.list.each do |name|
      definition = OpenApiDefinitionResolver.find(name)

      definition.endpoints.each do |endpoint|
        endpoint.responses.each do |response|
          next if response.code[0] == '2' # Successes don't have error messages

          response.formats.each do |format|
            schema = response.schema(format)

            # Turn everything in to an array to simplify things
            if schema['oneOf']
              properties = schema['oneOf']
            else
              properties = [schema['properties']]
            end

            properties.each do |property|
              type = property['type']

              # Skip if it's an old-style error
              next unless type

              # Grab the example URL
              example = type['example']

              # If it has an example field, and it's a link to NDP
              if example&.starts_with?('https://developer.nexmo.com/api-errors')

                # Extract the error
                error = example.split('#')[1]

                # Remove the production prefix
                path = example.gsub('https://developer.nexmo.com', '')

                # Get the page
                session.get path

                next if path.include?('/subaccounts')

                # Check for migration pending error
                CommonErrors.check_for_migration_error(session.body)

                # Make sure it includes the correct ID
                errors.push({ 'document' => name, 'path' => path }) unless session.response.body.include?("<tr id=\"#{error}\">")
              end
            end
          end
        end
      end
    end

    if errors.length.positive?
      errors = errors.map do |e|
        "#{e['path']} (#{e['document']})"
      end.uniq
      raise "Missing Errors:\n\n#{errors.join("\n")}"
    end
  end

  task 'check_word_blocklist': :environment do
    markdown_files =
      [
        "#{Rails.configuration.docs_base_path}/_documentation/en/**/*.md",
        "#{Rails.configuration.docs_base_path}/_api/**/*.md",
        "#{Rails.configuration.docs_base_path}/_tutorials/**/*.md",
        "#{Rails.configuration.docs_base_path}/_partials/*.md",
        "#{Rails.configuration.docs_base_path}/_partials/**/*.md",
        "#{Rails.configuration.docs_base_path}/_modals/**/*.md",
      ]

    block_list = File.read('.disallowed_words').split("\n")

    errors = []
    markdown_files.each do |path|
      Dir.glob(path).each do |filename|
        block_list.each do |word|
          word = word.downcase
          document = File.read(filename).downcase
          if document.include? word
            errors.push("#{word} found in #{filename.gsub("#{Rails.configuration.docs_base_path}/", '')}")
          end
        end
      end
    end

    if errors.length.positive?
      raise "Blocked words found:\n\n#{errors.join("\n")}"
    end
  end
end
