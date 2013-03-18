# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'label_gen/version'

Gem::Specification.new do |spec|
  spec.name          = "label_gen"
  spec.version       = LabelGen::VERSION
  spec.authors       = ["William Wedler"]
  spec.email         = ["wwedler@riseup.net"]
  spec.description   = %q{Utility for creating labels to track inventory}
  spec.summary       = %q{Create PDF pages to print number labels and while making sure duplicate numbers are not printed.}
  spec.homepage      = ""
  spec.license       = "See LICENSE"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'sqlite3', '~> 1.3.3'
  
  spec.add_dependency 'prawn', '~>0.12'
  spec.add_dependency 'thor', '~>0.17'
  
end
