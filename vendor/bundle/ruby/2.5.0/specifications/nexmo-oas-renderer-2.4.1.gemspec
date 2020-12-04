# -*- encoding: utf-8 -*-
# stub: nexmo-oas-renderer 2.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "nexmo-oas-renderer".freeze
  s.version = "2.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "https://github.com/Nexmo/nexmo-oas-renderer", "source_code_uri" => "https://github.com/Nexmo/nexmo-oas-renderer" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Fabian Rodriguez".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-11-19"
  s.email = ["fabian.rodriguez@vonage.com".freeze]
  s.executables = ["nexmo-oas-renderer".freeze]
  s.files = ["exe/nexmo-oas-renderer".freeze]
  s.homepage = "https://github.com/Nexmo/nexmo-oas-renderer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "OpenAPI Specification renderer.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>.freeze, ["~> 6.0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["~> 6.0"])
      s.add_runtime_dependency(%q<banzai>.freeze, ["~> 0.1.2"])
      s.add_runtime_dependency(%q<dotenv>.freeze, ["~> 2.7"])
      s.add_runtime_dependency(%q<neatjson>.freeze, ["~> 0.8"])
      s.add_runtime_dependency(%q<nexmo_markdown_renderer>.freeze, ["~> 0.3"])
      s.add_runtime_dependency(%q<oas_parser>.freeze, ["~> 0.25.1"])
      s.add_runtime_dependency(%q<octicons_helper>.freeze, ["~> 8.2"])
      s.add_runtime_dependency(%q<redcarpet>.freeze, ["= 3.4.0"])
      s.add_runtime_dependency(%q<sass>.freeze, ["~> 3.1"])
      s.add_runtime_dependency(%q<shotgun>.freeze, ["~> 0.9"])
      s.add_runtime_dependency(%q<sinatra>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.86"])
    else
      s.add_dependency(%q<activemodel>.freeze, ["~> 6.0"])
      s.add_dependency(%q<activesupport>.freeze, ["~> 6.0"])
      s.add_dependency(%q<banzai>.freeze, ["~> 0.1.2"])
      s.add_dependency(%q<dotenv>.freeze, ["~> 2.7"])
      s.add_dependency(%q<neatjson>.freeze, ["~> 0.8"])
      s.add_dependency(%q<nexmo_markdown_renderer>.freeze, ["~> 0.3"])
      s.add_dependency(%q<oas_parser>.freeze, ["~> 0.25.1"])
      s.add_dependency(%q<octicons_helper>.freeze, ["~> 8.2"])
      s.add_dependency(%q<redcarpet>.freeze, ["= 3.4.0"])
      s.add_dependency(%q<sass>.freeze, ["~> 3.1"])
      s.add_dependency(%q<shotgun>.freeze, ["~> 0.9"])
      s.add_dependency(%q<sinatra>.freeze, ["~> 2.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.86"])
    end
  else
    s.add_dependency(%q<activemodel>.freeze, ["~> 6.0"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 6.0"])
    s.add_dependency(%q<banzai>.freeze, ["~> 0.1.2"])
    s.add_dependency(%q<dotenv>.freeze, ["~> 2.7"])
    s.add_dependency(%q<neatjson>.freeze, ["~> 0.8"])
    s.add_dependency(%q<nexmo_markdown_renderer>.freeze, ["~> 0.3"])
    s.add_dependency(%q<oas_parser>.freeze, ["~> 0.25.1"])
    s.add_dependency(%q<octicons_helper>.freeze, ["~> 8.2"])
    s.add_dependency(%q<redcarpet>.freeze, ["= 3.4.0"])
    s.add_dependency(%q<sass>.freeze, ["~> 3.1"])
    s.add_dependency(%q<shotgun>.freeze, ["~> 0.9"])
    s.add_dependency(%q<sinatra>.freeze, ["~> 2.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.86"])
  end
end
