# -*- encoding: utf-8 -*-
# stub: truncato 0.7.11 ruby lib

Gem::Specification.new do |s|
  s.name = "truncato".freeze
  s.version = "0.7.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jorge Manrubia".freeze]
  s.date = "2013-09-10"
  s.description = "Ruby tool for truncating HTML strings keeping a valid HTML markup".freeze
  s.email = "jorge.manrubia@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "https://github.com/jorgemanrubia/truncato".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A tool for truncating HTML strings efficiently".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.7.0", "<= 2.0"])
      s.add_runtime_dependency(%q<htmlentities>.freeze, ["~> 4.3.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.14.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.1.1"])
    else
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.7.0", "<= 2.0"])
      s.add_dependency(%q<htmlentities>.freeze, ["~> 4.3.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.14.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.1.1"])
    end
  else
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.7.0", "<= 2.0"])
    s.add_dependency(%q<htmlentities>.freeze, ["~> 4.3.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.14.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.1.1"])
  end
end
