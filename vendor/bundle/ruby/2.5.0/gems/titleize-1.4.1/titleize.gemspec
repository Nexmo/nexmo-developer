# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "titleize/version"

Gem::Specification.new do |s|
  s.name        = "titleize"
  s.version     = Titleize::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grant Hollingworth"]
  s.email       = ["grant@antiflux.org"]
  s.homepage    = "http://rubygems.org/gems/titleize"
  s.summary     = "Adds String#titleize for creating properly capitalized titles."
  s.description = "#{s.summary} Replaces ActiveSupport::Inflector.titleize if ActiveSupport is present."

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.rubyforge_project = "titleize"

  s.add_development_dependency "rspec", "~> 2.13"
  s.add_development_dependency "rake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
