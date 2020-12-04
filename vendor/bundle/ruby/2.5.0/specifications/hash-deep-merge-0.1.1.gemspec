# -*- encoding: utf-8 -*-
# stub: hash-deep-merge 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "hash-deep-merge".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Offirmo".freeze]
  s.date = "2011-05-23"
  s.description = "This gem add the \"deep merge\" feature to class Hash.\nIt means that if you want to merge hashes that contains other hashes (and so on...), those sub-hashes will be merged as well.\nThis is very handy, for example for merging data taken from YAML files.\n".freeze
  s.email = "offirmo.net@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/Offirmo/hash-deep-merge".freeze
  s.licenses = ["CC0 1.0".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "add the deep merge feature to class Hash.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rcov>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_dependency(%q<rcov>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_dependency(%q<rcov>.freeze, [">= 0"])
  end
end
