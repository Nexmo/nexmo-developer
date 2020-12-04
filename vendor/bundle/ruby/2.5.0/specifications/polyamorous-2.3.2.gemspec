# -*- encoding: utf-8 -*-
# stub: polyamorous 2.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "polyamorous".freeze
  s.version = "2.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ernie Miller".freeze, "Ryan Bigg".freeze, "Jon Atack".freeze, "Xiang Li".freeze]
  s.date = "2020-01-13"
  s.description = "\n    This is just an extraction from Ransack/Squeel. You probably don't want to use this\n    directly. It extends ActiveRecord's associations to support polymorphic belongs_to\n    associations.\n  ".freeze
  s.email = ["ernie@erniemiller.org".freeze, "radarlistener@gmail.com".freeze, "jonnyatack@gmail.com".freeze, "bigxiang@gmail.com".freeze]
  s.homepage = "https://github.com/activerecord-hackery/ransack/tree/master/polyamorous".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Loves/is loved by polymorphic belongs_to associations, Ransack, Squeel, MetaSearch...".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 5.2.1"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 5.2.1"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 5.2.1"])
  end
end
