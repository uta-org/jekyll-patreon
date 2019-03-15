# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "jekyll-patreon/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-patreon"
  spec.summary       = "Jekyll Patreon integration"
  spec.description   = "Patreon support in Jekyll blog to easily embed a widget with your goals"
  spec.version       = Jekyll::Patreon::VERSION
  spec.authors       = ["z3nth10n"]
  spec.email         = ["z3nth10n@gmail.com"]
  spec.homepage      = "https://github.com/uta-org/jekyll-patreon"
  spec.licenses      = ["MIT"]
    
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|spec|features)/!) }
  spec.require_paths = ["lib"]
    
  spec.add_dependency "jekyll", "~> 3.0"
    
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rubocop", "~> 0.41"
end