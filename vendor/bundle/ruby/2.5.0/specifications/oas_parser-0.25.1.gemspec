# -*- encoding: utf-8 -*-
# stub: oas_parser 0.25.1 ruby lib

Gem::Specification.new do |s|
  s.name = "oas_parser".freeze
  s.version = "0.25.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Butler".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-04-20"
  s.email = ["adam@lab.io".freeze]
  s.homepage = "https://github.com/Nexmo/oas_parser".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A parser for Open API specifications".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_runtime_dependency(%q<deep_merge>.freeze, ["~> 1.2.1"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.0.0"])
      s.add_runtime_dependency(%q<builder>.freeze, ["~> 3.2.3"])
      s.add_runtime_dependency(%q<mustermann-contrib>.freeze, ["~> 1.1.1"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<hash-deep-merge>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4.7.3"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.1.3"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.11.3"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.15.1"])
    else
      s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_dependency(%q<deep_merge>.freeze, ["~> 1.2.1"])
      s.add_dependency(%q<activesupport>.freeze, [">= 4.0.0"])
      s.add_dependency(%q<builder>.freeze, ["~> 3.2.3"])
      s.add_dependency(%q<mustermann-contrib>.freeze, ["~> 1.1.1"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_dependency(%q<hash-deep-merge>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 2.1"])
      s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.7.3"])
      s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.1.3"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.11.3"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.15.1"])
    end
  else
    s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
    s.add_dependency(%q<deep_merge>.freeze, ["~> 1.2.1"])
    s.add_dependency(%q<activesupport>.freeze, [">= 4.0.0"])
    s.add_dependency(%q<builder>.freeze, ["~> 3.2.3"])
    s.add_dependency(%q<mustermann-contrib>.freeze, ["~> 1.1.1"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<hash-deep-merge>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.1"])
    s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.7.3"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.1.3"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.11.3"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.15.1"])
  end
end
