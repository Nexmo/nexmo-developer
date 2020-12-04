# -*- encoding: utf-8 -*-
# stub: has_scope 0.7.2 ruby lib

Gem::Specification.new do |s|
  s.name = "has_scope".freeze
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jos\u00E9 Valim".freeze]
  s.date = "2018-04-10"
  s.description = "Maps controller filters to your resource scopes".freeze
  s.email = "opensource@plataformatec.com.br".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "http://github.com/plataformatec/has_scope".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.7".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Maps controller filters to your resource scopes.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 4.1"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 1.0.0"])
    else
      s.add_dependency(%q<actionpack>.freeze, [">= 4.1"])
      s.add_dependency(%q<activesupport>.freeze, [">= 4.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, ["~> 1.0.0"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 4.1"])
    s.add_dependency(%q<activesupport>.freeze, [">= 4.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.0.0"])
  end
end
