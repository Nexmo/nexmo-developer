lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/nexmo_developer/version"

Gem::Specification.new do |spec|
  spec.name          = "nexmo-developer"
  spec.version       = NexmoDeveloper::VERSION
  spec.authors       = ["Nexmo DevRel"]
  spec.email         = ["devrel@nexmo.com"]
  spec.executables   << 'nexmo-developer'

  spec.summary       = %q{Nexmo Developer Platform}
  spec.homepage      = "https://github.com/Nexmo/nexmo-developer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/Nexmo/nexmo-developer"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|_api|_code|_documentation|_examples|_extend|_modals|_open_api|_tutorials|_tutorials_tabbed_content|_use_cases|_partials|sample_config_files|.repos)/}) }
  end
  spec.files         += Dir.glob('./lib/nexmo_developer/public/**/*', File::FNM_DOTMATCH)
  spec.files.reject! { |fn| fn.include? 'lib/nexmo_developer/spec' }
  spec.files.reject! { |fn| fn.include? '.github' }
  spec.files.reject! { |fn| fn.include? 'lib/nexmo_developer/public/sdk' }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency('activeadmin', '~> 2.6')
  spec.add_runtime_dependency('rails', '~> 6.0')
  spec.add_runtime_dependency('bootsnap', '~> 1.4')
  spec.add_runtime_dependency('nexmo-oas-renderer', '~> 0.11')
  #spec.add_runtime_dependency('nexmo_markdown_renderer', '~> 0.3')
  spec.add_runtime_dependency('activesupport', '~> 6.0')
  spec.add_runtime_dependency('bugsnag', '~> 6.13')
  spec.add_runtime_dependency('railties', '~> 6.0')
  spec.add_runtime_dependency('devise', '~> 4.7')
  spec.add_runtime_dependency('geocoder', '~> 1.6')
  spec.add_runtime_dependency('gravatar_image_tag', '~> 1.2')
  spec.add_runtime_dependency('greenhouse_io', '~> 2.5')
  spec.add_runtime_dependency('recaptcha', '~> 5.3')
  spec.add_runtime_dependency('split', '~> 3.4')
  spec.add_runtime_dependency('listen', '~> 3.2')
  spec.add_runtime_dependency('inherited_resources', '~> 1.11')
  spec.add_runtime_dependency('msgpack', '~> 1.3')
  spec.add_runtime_dependency('pg', '~> 1.2')
  spec.add_runtime_dependency('coffee-rails', '~> 5.0')
  spec.add_runtime_dependency('octokit', '~> 4.18')
  spec.add_runtime_dependency('icalendar', '~> 2.6')
  spec.add_runtime_dependency('diffy', '~> 3.3')
  spec.add_runtime_dependency('webpacker', '~> 5.1')
  spec.add_runtime_dependency('clipboard-rails', '~> 1.7')
  spec.add_runtime_dependency('gmaps4rails', '~> 2.1')
  spec.add_runtime_dependency('truncato', '~> 0.7.11')
  spec.add_runtime_dependency('puma', '~> 4.3')
  spec.add_runtime_dependency('barnes', '0.0.8')
  spec.add_runtime_dependency('woothee', '~> 1.11')
  spec.add_runtime_dependency('algoliasearch', '1.27.2')
  spec.add_runtime_dependency('rest-client', '2.1.0')
  spec.add_runtime_dependency('chartkick', '3.3.1')
  spec.add_runtime_dependency('groupdate', '5.0.0')
  spec.add_runtime_dependency('terminal-table', '1.8.0')
  spec.add_runtime_dependency('lograge', '0.11.2')
  spec.add_runtime_dependency('sassc-rails', '2.1.2')
  spec.add_runtime_dependency('uglifier', '4.2.0')
  spec.add_runtime_dependency('jquery-rails', '4.4.0')
  spec.add_runtime_dependency('jbuilder', '2.10.0')
  spec.add_runtime_dependency('nokogiri', '1.10.9')
  spec.add_runtime_dependency('ruby-progressbar', '1.10.1')
  spec.add_runtime_dependency('colorize', '0.8.1')
  spec.add_runtime_dependency('neatjson', '0.9')
  spec.add_runtime_dependency('slack-notifier', '2.3.2')
  spec.add_runtime_dependency('autoprefixer-rails', '9.7.6')
  spec.add_runtime_dependency('titleize', '1.4.1')
  spec.add_runtime_dependency('countries', '3.0.1')
  spec.add_runtime_dependency('country_select', '4.0.0')
  spec.add_runtime_dependency('smartling', '2.0.3')
  spec.add_runtime_dependency('newrelic_rpm', '6.10.0.364')
  spec.add_runtime_dependency('redis', '4.1.4')
end
