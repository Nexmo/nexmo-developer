# -*- encoding: utf-8 -*-
# stub: banzai 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "banzai".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dejan Simic".freeze]
  s.date = "2018-03-09"
  s.description = "Toolkit for processing input using filters and pipelines".freeze
  s.email = ["desimic@gmail.com".freeze]
  s.homepage = "https://github.com/dejan/banzai".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Toolkit for processing input using filters and pipelines".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.53.0"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9.12"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 12.3.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.53.0"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9.12"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 12.3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.53.0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.12"])
  end
end
