
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "oas_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "oas_parser"
  spec.version       = OasParser::VERSION
  spec.authors       = ["Adam Butler"]
  spec.email         = ["adam@lab.io"]

  spec.summary       = %q{A parser for Open API specifications}
  spec.homepage      = "https://github.com/Nexmo/oas_parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "addressable", "~> 2.3"
  spec.add_dependency "deep_merge", "~> 1.2.1"
  spec.add_dependency "activesupport", ">= 4.0.0"
  spec.add_dependency "builder", "~> 3.2.3"
  spec.add_dependency "mustermann-contrib", "~> 1.1.1"
  spec.add_dependency "nokogiri"
  spec.add_dependency "hash-deep-merge"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-collection_matchers", "~> 1.1.3"
  spec.add_development_dependency "pry", "~> 0.11.3"
  spec.add_development_dependency "simplecov", "~> 0.15.1"
end
