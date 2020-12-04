# -*- encoding: utf-8 -*-
# stub: httmultiparty 0.3.16 ruby lib

Gem::Specification.new do |s|
  s.name = "httmultiparty".freeze
  s.version = "0.3.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Johannes Wagener".freeze]
  s.date = "2014-10-02"
  s.description = "HTTMultiParty is a thin wrapper around HTTParty to provide multipart uploads.".freeze
  s.email = ["johannes@wagener.cc".freeze]
  s.homepage = "http://github.com/jwagener/httmultiparty".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "HTTMultiParty is a thin wrapper around HTTParty to provide multipart uploads.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>.freeze, [">= 0.7.3"])
      s.add_runtime_dependency(%q<multipart-post>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<mimemagic>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<fakeweb>.freeze, [">= 0"])
    else
      s.add_dependency(%q<httparty>.freeze, [">= 0.7.3"])
      s.add_dependency(%q<multipart-post>.freeze, [">= 0"])
      s.add_dependency(%q<mimemagic>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<fakeweb>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>.freeze, [">= 0.7.3"])
    s.add_dependency(%q<multipart-post>.freeze, [">= 0"])
    s.add_dependency(%q<mimemagic>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<fakeweb>.freeze, [">= 0"])
  end
end
