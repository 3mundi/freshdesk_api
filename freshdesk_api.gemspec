# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freshdesk_api/version'

Gem::Specification.new do |spec|
  spec.name          = "freshdesk_api"
  spec.version       = FreshdeskAPI::VERSION
  spec.authors       = ["Artur Panach"]
  spec.email         = ["arturictus@gmail.com"]

  spec.summary       = %q{Freshdesk API wrapper.}
  spec.description   = %q{Freshdesk API wrapper.}
  spec.homepage      = "https://github.com/3mundi/freshdesk_api"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "vcr", "~> 3"
  spec.add_development_dependency "rspec-its"
  spec.add_dependency "http", "~> 2"
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'virtus', '~> 1'
end
