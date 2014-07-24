# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puma_instrument/version'

Gem::Specification.new do |gem|
  gem.name          = "puma_instrument"
  gem.version       = PumaInstrument::VERSION
  gem.authors       = ["Markus Seeger"]
  gem.email         = ["mail@codegourmet.de"]
  gem.description   = %q{ Monitors puma memory consumption via statsd }
  gem.summary       = %q{ Useful for finding memory leaks }
  gem.homepage      = "https://github.com/codegourmet/puma_instrument"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "puma",              "~>  2.7"
  gem.add_dependency "get_process_mem",   "~>  0.2"
  gem.add_development_dependency "rake",  "~> 10.1"
end
