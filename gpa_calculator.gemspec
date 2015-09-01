# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gpa_calculator/version'

Gem::Specification.new do |spec|
  spec.name          = "gpa_calculator"
  spec.version       =  GpaCalculator::VERSION
  spec.authors       = ["Sarah W."]
  spec.email         = ["sarahcwheeler@gmail.com"]
  spec.summary       = "GPA calculator and grade report generator."
  spec.description   = "Provide course names and scores, and your GPA will be automatically generated."
  spec.homepage      = "http://rubygems.org/gems/gpa_calculator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "2.14.1"
end
