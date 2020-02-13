DocFinder.configure do |config|
  config.paths << "#{Rails.configuration.docs_base_path}/_documentation"
  config.paths << "#{Rails.configuration.docs_base_path}/_use_cases"
  config.paths << "#{Rails.configuration.docs_base_path}/_tutorials"
  config.paths << 'config/tutorials'
  config.paths << 'app/views/product-lifecycle'
  config.paths << 'app/views/contribute'
end
