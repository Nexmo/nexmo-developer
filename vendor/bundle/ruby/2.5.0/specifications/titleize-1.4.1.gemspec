# -*- encoding: utf-8 -*-
# stub: titleize 1.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "titleize".freeze
  s.version = "1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Grant Hollingworth".freeze]
  s.date = "2016-09-16"
  s.description = "Adds String#titleize for creating properly capitalized titles. Replaces ActiveSupport::Inflector.titleize if ActiveSupport is present.".freeze
  s.email = ["grant@antiflux.org".freeze]
  s.homepage = "http://rubygems.org/gems/titleize".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Adds String#titleize for creating properly capitalized titles.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.13"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 2.13"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 2.13"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
