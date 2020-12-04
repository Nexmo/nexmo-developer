# -*- encoding: utf-8 -*-
# stub: mustermann-contrib 1.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "mustermann-contrib".freeze
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Konstantin Haase".freeze, "Zachary Scott".freeze]
  s.date = "2020-01-03"
  s.description = "Adds many plugins to Mustermann".freeze
  s.email = "sinatrarb@googlegroups.com".freeze
  s.homepage = "https://github.com/sinatra/mustermann".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Collection of extensions for Mustermann".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mustermann>.freeze, ["= 1.1.1"])
      s.add_runtime_dependency(%q<hansi>.freeze, ["~> 0.2.0"])
    else
      s.add_dependency(%q<mustermann>.freeze, ["= 1.1.1"])
      s.add_dependency(%q<hansi>.freeze, ["~> 0.2.0"])
    end
  else
    s.add_dependency(%q<mustermann>.freeze, ["= 1.1.1"])
    s.add_dependency(%q<hansi>.freeze, ["~> 0.2.0"])
  end
end
