lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nexmo/oas/renderer/version'

Gem::Specification.new do |spec|
  spec.name          = 'nexmo-oas-renderer'
  spec.version       = Nexmo::OAS::Renderer::VERSION
  spec.authors       = ['Fabian Rodriguez']
  spec.email         = ['fabian.rodriguez@vonage.com']

  spec.summary       = 'OpenAPI Specification renderer.'
  spec.homepage      = 'https://github.com/Nexmo/nexmo-oas-renderer'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/Nexmo/nexmo-oas-renderer'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|samples)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activemodel', '~> 6.0'
  spec.add_runtime_dependency 'activesupport', '~> 6.0'
  spec.add_runtime_dependency 'banzai', '~> 0.1.2'
  spec.add_runtime_dependency 'dotenv', '~> 2.7'
  spec.add_runtime_dependency 'neatjson', '~> 0.8'
  spec.add_runtime_dependency 'nexmo_markdown_renderer', '~> 0.3'
  spec.add_runtime_dependency 'oas_parser', '~> 0.25.1'
  spec.add_runtime_dependency 'octicons_helper', '~> 8.2'
  spec.add_runtime_dependency 'redcarpet', '3.4.0'
  spec.add_runtime_dependency 'sass', '~> 3.1'
  spec.add_runtime_dependency 'shotgun', '~> 0.9'
  spec.add_runtime_dependency 'sinatra', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.86'
end
