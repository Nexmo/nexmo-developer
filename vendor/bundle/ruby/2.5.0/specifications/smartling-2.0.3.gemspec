# -*- encoding: utf-8 -*-
# stub: smartling 2.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "smartling".freeze
  s.version = "2.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Emilien Huet".freeze]
  s.date = "2017-05-19"
  s.description = "A Ruby library to utilize Smartling services".freeze
  s.email = ["hi@smartling.com".freeze]
  s.homepage = "http://docs.smartling.com".freeze
  s.licenses = ["LICENSE".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.9".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Smartling SDK".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oj>.freeze, ["~> 3.0"])
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<rest-client>.freeze, ["~> 2.0"])
    else
      s.add_dependency(%q<oj>.freeze, ["~> 3.0"])
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rest-client>.freeze, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<oj>.freeze, ["~> 3.0"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rest-client>.freeze, ["~> 2.0"])
  end
end
