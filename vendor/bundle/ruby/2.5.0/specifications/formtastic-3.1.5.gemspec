# -*- encoding: utf-8 -*-
# stub: formtastic 3.1.5 ruby lib

Gem::Specification.new do |s|
  s.name = "formtastic".freeze
  s.version = "3.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Justin French".freeze]
  s.date = "2017-02-23"
  s.description = "A Rails form builder plugin/gem with semantically rich and accessible markup".freeze
  s.email = ["justin@indent.com.au".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "http://github.com/justinfrench/formtastic".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A Rails form builder plugin/gem with semantically rich and accessible markup".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.2.13"])
      s.add_development_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.3.2"])
      s.add_development_dependency(%q<rspec_tag_matchers>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<hpricot>.freeze, ["~> 0.8.3"])
      s.add_development_dependency(%q<RedCloth>.freeze, ["~> 4.2"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.8"])
      s.add_development_dependency(%q<colored>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_development_dependency(%q<ammeter>.freeze, ["~> 1.1.3"])
      s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<rake>.freeze, ["< 12"])
      s.add_development_dependency(%q<activemodel>.freeze, [">= 3.2.13"])
    else
      s.add_dependency(%q<actionpack>.freeze, [">= 3.2.13"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.3.2"])
      s.add_dependency(%q<rspec_tag_matchers>.freeze, ["~> 1.0"])
      s.add_dependency(%q<hpricot>.freeze, ["~> 0.8.3"])
      s.add_dependency(%q<RedCloth>.freeze, ["~> 4.2"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.8"])
      s.add_dependency(%q<colored>.freeze, ["~> 1.2"])
      s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_dependency(%q<ammeter>.freeze, ["~> 1.1.3"])
      s.add_dependency(%q<appraisal>.freeze, ["~> 2.1"])
      s.add_dependency(%q<rake>.freeze, ["< 12"])
      s.add_dependency(%q<activemodel>.freeze, [">= 3.2.13"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 3.2.13"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.3.2"])
    s.add_dependency(%q<rspec_tag_matchers>.freeze, ["~> 1.0"])
    s.add_dependency(%q<hpricot>.freeze, ["~> 0.8.3"])
    s.add_dependency(%q<RedCloth>.freeze, ["~> 4.2"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.8"])
    s.add_dependency(%q<colored>.freeze, ["~> 1.2"])
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_dependency(%q<ammeter>.freeze, ["~> 1.1.3"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.1"])
    s.add_dependency(%q<rake>.freeze, ["< 12"])
    s.add_dependency(%q<activemodel>.freeze, [">= 3.2.13"])
  end
end
