# -*- encoding: utf-8 -*-
# stub: arbre 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "arbre".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Greg Bell".freeze]
  s.date = "2020-09-04"
  s.description = "Arbre makes it easy to generate HTML directly in Ruby".freeze
  s.email = ["gregdbell@gmail.com".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "README.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "README.md".freeze]
  s.homepage = "https://github.com/activeadmin/arbre".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "An Object Oriented DOM Tree in Ruby".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.0", "< 6.1"])
      s.add_runtime_dependency(%q<ruby2_keywords>.freeze, [">= 0.0.2", "< 1.0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0", "< 6.1"])
      s.add_dependency(%q<ruby2_keywords>.freeze, [">= 0.0.2", "< 1.0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0", "< 6.1"])
    s.add_dependency(%q<ruby2_keywords>.freeze, [">= 0.0.2", "< 1.0"])
  end
end
