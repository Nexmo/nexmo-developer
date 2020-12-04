# -*- encoding: utf-8 -*-
# stub: nexmo_markdown_renderer 0.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "nexmo_markdown_renderer".freeze
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/Nexmo/nexmo-markdown-renderer/issues", "changelog_uri" => "https://github.com/Nexmo/nexmo-markdown-renderer/blob/master/CHANGES.md", "homepage" => "https://github.com/Nexmo/nexmo-markdown-renderer", "source_code_uri" => "https://github.com/Nexmo/nexmo-markdown-renderer" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nexmo".freeze]
  s.date = "2020-11-26"
  s.description = "Middleware to render Markdown Documents in Nexmo Developer Platform.".freeze
  s.email = ["devrel@nexmo.com".freeze]
  s.homepage = "https://github.com/Nexmo/nexmo-markdown-renderer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Middleware to render Markdown Documents in Nexmo Developer Platform.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<banzai>.freeze, ["~> 0.1.2"])
      s.add_runtime_dependency(%q<octicons_helper>.freeze, ["~> 8.2"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.10"])
      s.add_runtime_dependency(%q<redcarpet>.freeze, ["~> 3.4"])
      s.add_runtime_dependency(%q<rouge>.freeze, ["~> 2.0.7"])
      s.add_runtime_dependency(%q<activemodel>.freeze, ["~> 6.0"])
      s.add_runtime_dependency(%q<i18n>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8.15"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.2.0"])
      s.add_development_dependency(%q<rspec-snapshot>.freeze, ["~> 0.1.2"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_development_dependency(%q<capybara>.freeze, ["~> 3.31"])
    else
      s.add_dependency(%q<banzai>.freeze, ["~> 0.1.2"])
      s.add_dependency(%q<octicons_helper>.freeze, ["~> 8.2"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.10"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.4"])
      s.add_dependency(%q<rouge>.freeze, ["~> 2.0.7"])
      s.add_dependency(%q<activemodel>.freeze, ["~> 6.0"])
      s.add_dependency(%q<i18n>.freeze, ["~> 1.7"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.16"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.15"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.7"])
      s.add_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.2.0"])
      s.add_dependency(%q<rspec-snapshot>.freeze, ["~> 0.1.2"])
      s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_dependency(%q<capybara>.freeze, ["~> 3.31"])
    end
  else
    s.add_dependency(%q<banzai>.freeze, ["~> 0.1.2"])
    s.add_dependency(%q<octicons_helper>.freeze, ["~> 8.2"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.10"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rouge>.freeze, ["~> 2.0.7"])
    s.add_dependency(%q<activemodel>.freeze, ["~> 6.0"])
    s.add_dependency(%q<i18n>.freeze, ["~> 1.7"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.15"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.7"])
    s.add_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.2.0"])
    s.add_dependency(%q<rspec-snapshot>.freeze, ["~> 0.1.2"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<capybara>.freeze, ["~> 3.31"])
  end
end
