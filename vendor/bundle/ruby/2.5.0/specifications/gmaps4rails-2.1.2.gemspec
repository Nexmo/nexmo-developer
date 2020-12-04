# -*- encoding: utf-8 -*-
# stub: gmaps4rails 2.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "gmaps4rails".freeze
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Benjamin Roth".freeze, "David Ruyer".freeze]
  s.date = "2014-02-17"
  s.description = "Enables easy Google map + overlays creation.".freeze
  s.email = ["apnea.diving.deep@gmail.com".freeze, "david.ruyer@gmail.com".freeze]
  s.homepage = "http://github.com/apneadiving/Google-Maps-for-Rails".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Maps made easy for Ruby apps".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["= 2.14.0"])
      s.add_development_dependency(%q<rake>.freeze, ["= 10.1.0"])
      s.add_development_dependency(%q<coffee-script>.freeze, [">= 0"])
      s.add_development_dependency(%q<sprockets>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["= 2.14.0"])
      s.add_dependency(%q<rake>.freeze, ["= 10.1.0"])
      s.add_dependency(%q<coffee-script>.freeze, [">= 0"])
      s.add_dependency(%q<sprockets>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["= 2.14.0"])
    s.add_dependency(%q<rake>.freeze, ["= 10.1.0"])
    s.add_dependency(%q<coffee-script>.freeze, [">= 0"])
    s.add_dependency(%q<sprockets>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
