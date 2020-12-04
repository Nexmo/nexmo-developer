# -*- encoding: utf-8 -*-
# stub: activeadmin 2.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "activeadmin".freeze
  s.version = "2.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Charles Maresh".freeze, "David Rodr\u00EDguez".freeze, "Greg Bell".freeze, "Igor Fedoronchuk".freeze, "Javier Julio".freeze, "Piers C".freeze, "Sean Linsley".freeze, "Timo Schilling".freeze]
  s.date = "2020-09-28"
  s.description = "The administration framework for Ruby on Rails.".freeze
  s.email = ["deivid.rodriguez@riseup.net".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "README.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "README.md".freeze]
  s.homepage = "https://activeadmin.info".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Active Admin is a Ruby on Rails plugin for generating administration style interfaces. It abstracts common business application patterns to make it simple for developers to implement beautiful and elegant interfaces with very little effort.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<arbre>.freeze, ["~> 1.2", ">= 1.2.1"])
      s.add_runtime_dependency(%q<formtastic>.freeze, [">= 3.1", "< 5.0"])
      s.add_runtime_dependency(%q<formtastic_i18n>.freeze, ["~> 0.4"])
      s.add_runtime_dependency(%q<inherited_resources>.freeze, ["~> 1.7"])
      s.add_runtime_dependency(%q<jquery-rails>.freeze, ["~> 4.2"])
      s.add_runtime_dependency(%q<kaminari>.freeze, ["~> 1.0", ">= 1.2.1"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 5.2", "< 6.1"])
      s.add_runtime_dependency(%q<ransack>.freeze, ["~> 2.1", ">= 2.1.1"])
      s.add_runtime_dependency(%q<sassc-rails>.freeze, ["~> 2.1"])
      s.add_runtime_dependency(%q<sprockets>.freeze, [">= 3.0", "< 4.1"])
    else
      s.add_dependency(%q<arbre>.freeze, ["~> 1.2", ">= 1.2.1"])
      s.add_dependency(%q<formtastic>.freeze, [">= 3.1", "< 5.0"])
      s.add_dependency(%q<formtastic_i18n>.freeze, ["~> 0.4"])
      s.add_dependency(%q<inherited_resources>.freeze, ["~> 1.7"])
      s.add_dependency(%q<jquery-rails>.freeze, ["~> 4.2"])
      s.add_dependency(%q<kaminari>.freeze, ["~> 1.0", ">= 1.2.1"])
      s.add_dependency(%q<railties>.freeze, [">= 5.2", "< 6.1"])
      s.add_dependency(%q<ransack>.freeze, ["~> 2.1", ">= 2.1.1"])
      s.add_dependency(%q<sassc-rails>.freeze, ["~> 2.1"])
      s.add_dependency(%q<sprockets>.freeze, [">= 3.0", "< 4.1"])
    end
  else
    s.add_dependency(%q<arbre>.freeze, ["~> 1.2", ">= 1.2.1"])
    s.add_dependency(%q<formtastic>.freeze, [">= 3.1", "< 5.0"])
    s.add_dependency(%q<formtastic_i18n>.freeze, ["~> 0.4"])
    s.add_dependency(%q<inherited_resources>.freeze, ["~> 1.7"])
    s.add_dependency(%q<jquery-rails>.freeze, ["~> 4.2"])
    s.add_dependency(%q<kaminari>.freeze, ["~> 1.0", ">= 1.2.1"])
    s.add_dependency(%q<railties>.freeze, [">= 5.2", "< 6.1"])
    s.add_dependency(%q<ransack>.freeze, ["~> 2.1", ">= 2.1.1"])
    s.add_dependency(%q<sassc-rails>.freeze, ["~> 2.1"])
    s.add_dependency(%q<sprockets>.freeze, [">= 3.0", "< 4.1"])
  end
end
