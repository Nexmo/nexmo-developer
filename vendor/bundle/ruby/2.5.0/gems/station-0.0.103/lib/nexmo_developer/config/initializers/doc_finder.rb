return unless ENV['DOCS_BASE_PATH']

Nexmo::Markdown::DocFinder.configure do |config|
  config.paths << "#{Rails.configuration.docs_base_path}/_documentation"
  config.paths << "#{Rails.configuration.docs_base_path}/_use_cases"
  config.paths << "#{Rails.configuration.docs_base_path}/_tutorials"
  config.paths << "#{Rails.configuration.docs_base_path}/config/tutorials"
  config.paths << "#{Rails.root}/app/views/product-lifecycle"
  config.paths << "#{Rails.root}/app/views/contribute"
end
