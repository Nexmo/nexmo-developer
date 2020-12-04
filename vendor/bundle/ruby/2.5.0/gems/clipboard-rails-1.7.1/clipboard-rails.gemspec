# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clipboard/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "clipboard-rails"
  spec.version       = Clipboard::Rails::VERSION
  spec.authors       = ["Mohammed Sadiq"]
  spec.email         = ["sadiqmmm@gmail.com"]

  spec.summary       = spec.description
  spec.description   = 'This gem provides the clipboard.js Javascript library for your Rails 4 and Rails 5 application.'
  spec.homepage      = 'https://github.com/sadiqmmm/clipboard-rails'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
