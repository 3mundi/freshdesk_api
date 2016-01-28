# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freshdesk_api/version'

Gem::Specification.new do |spec|
  spec.name          = "freshdesk_api"
  spec.version       = FreshdeskAPI::VERSION
  spec.authors       = ["Artur Pañach"]
  spec.email         = ["arturictus@gmail.com"]

  spec.summary       = %q{Gem to interact with FreshdeskAPI.}
  spec.description   = %q{Gem to interact with FreshdeskAPI.}
  spec.homepage      = "https://github.com/3mundi/freshdesk_api"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "vcr", "~> 3"
  spec.add_development_dependency "rspec-its"
  spec.add_dependency "http", "~> 0.9.8"
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'virtus', '~> 1'
end
