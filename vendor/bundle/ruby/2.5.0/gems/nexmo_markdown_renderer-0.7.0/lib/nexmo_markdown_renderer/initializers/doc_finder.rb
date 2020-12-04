Nexmo::Markdown::DocFinder.configure do |config|
  config.paths << "#{Nexmo::Markdown::Config.docs_base_path}/_documentation"
  config.paths << "#{Nexmo::Markdown::Config.docs_base_path}/_use_cases"
  config.paths << "#{Nexmo::Markdown::Config.docs_base_path}/_tutorials"
end
