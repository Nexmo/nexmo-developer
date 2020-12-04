# -*- encoding: utf-8 -*-
# stub: countries 3.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "countries".freeze
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Josh Robinson".freeze, "Joe Corcoran".freeze, "Russell Osborne".freeze]
  s.date = "2020-02-11"
  s.description = "All sorts of useful information about every country packaged as pretty little country objects. It includes data from ISO 3166".freeze
  s.email = ["hexorx@gmail.com".freeze, "russell@burningpony.com".freeze]
  s.homepage = "http://github.com/hexorx/countries".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Gives you a country object full of all sorts of useful information.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n_data>.freeze, ["~> 0.10.0"])
      s.add_runtime_dependency(%q<unicode_utils>.freeze, ["~> 1.4"])
      s.add_runtime_dependency(%q<sixarm_ruby_unaccent>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3"])
      s.add_development_dependency(%q<activesupport>.freeze, [">= 3"])
      s.add_development_dependency(%q<nokogiri>.freeze, [">= 1.8"])
    else
      s.add_dependency(%q<i18n_data>.freeze, ["~> 0.10.0"])
      s.add_dependency(%q<unicode_utils>.freeze, ["~> 1.4"])
      s.add_dependency(%q<sixarm_ruby_unaccent>.freeze, ["~> 1.1"])
      s.add_dependency(%q<rspec>.freeze, [">= 3"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.8"])
    end
  else
    s.add_dependency(%q<i18n_data>.freeze, ["~> 0.10.0"])
    s.add_dependency(%q<unicode_utils>.freeze, ["~> 1.4"])
    s.add_dependency(%q<sixarm_ruby_unaccent>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rspec>.freeze, [">= 3"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.8"])
  end
end
