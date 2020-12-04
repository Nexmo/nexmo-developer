# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'woothee/version'

Gem::Specification.new do |gem|
  gem.name        = "woothee"
  gem.description = "Cross-language UserAgent classifier library, ruby implementation"
  gem.homepage    = "https://github.com/woothee/woothee-ruby"
  gem.summary     = gem.description
  gem.version     = Woothee::VERSION
  gem.authors     = ["TAGOMORI Satoshi"]
  gem.email       = "tagomoris@gmail.com"
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 2.8.0"
end
