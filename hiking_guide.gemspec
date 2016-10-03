# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hiking_guide/version'

Gem::Specification.new do |spec|
  spec.name          = "hiking_guide"
  spec.version       = HikingGuide::VERSION
  spec.authors       = ["Eleanor Graham"]
  spec.email         = ["eleanorcjkgraham@gmail.com"]

  spec.summary       = "CLI Gem that shows hiking trails from HikingUpward"
  spec.description   = "Hiking Guide is a CLI Gem that allows users to browse trails in the US mid Atlantic region, taking descriptions from Hiking Upward."
  spec.homepage      = "https://github.com/eleanorgraham/hiking_guide"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["hiking-guide"]
  spec.require_paths = ["lib, lib/hiking_guide"]

  spec.post_install_message = "Thanks for installing! Hit the trails!"

  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
  spec.add_runtime_dependency 'colorize', '~> 0.8', '>= 0.8.1'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10'
end
