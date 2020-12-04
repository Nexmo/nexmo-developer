# -*- encoding: utf-8 -*-
# stub: simple-random 1.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "simple-random".freeze
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John D. Cook".freeze, "Jason Adams".freeze]
  s.date = "2015-11-25"
  s.description = "Simple Random Number Generator including Beta, Cauchy, Chi square, Exponential, Gamma, Inverse Gamma, Laplace (double exponential), Normal, Student t, Uniform, and Weibull.  Ported from John D. Cook's C# Code.".freeze
  s.email = "jasonmadams@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze]
  s.homepage = "http://github.com/ealdent/simple-random".freeze
  s.licenses = ["CDDL-1.0".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Simple Random Number Generator".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<awesome_print>.freeze, [">= 1.6"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<shoulda>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    else
      s.add_dependency(%q<awesome_print>.freeze, [">= 1.6"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<shoulda>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<awesome_print>.freeze, [">= 1.6"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end
