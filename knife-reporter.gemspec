# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-reporter/version'

Gem::Specification.new do |gem|
  gem.name          = "knife-reporter"
  gem.version       = Knife::Reporter::VERSION
  gem.authors       = ["Benjamin W. Smith"]
  gem.email         = ["benjaminwarfield@gmail.com"]
  gem.description   = %q{Knife plugin to generate reports and documentation from chef API data via knife.}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
