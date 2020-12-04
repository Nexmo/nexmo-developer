# -*- encoding: utf-8 -*-
# stub: hansi 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hansi".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Konstantin Haase".freeze]
  s.date = "2016-03-01"
  s.description = "Der ANSI Hansi - create colorized console output.".freeze
  s.email = "konstantin.mailinglists@googlemail.com".freeze
  s.homepage = "https://github.com/rkh/hansi".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Hipster ANSI color library".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<tool>.freeze, ["~> 0.2"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    else
      s.add_dependency(%q<tool>.freeze, ["~> 0.2"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<tool>.freeze, ["~> 0.2"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
  end
end
