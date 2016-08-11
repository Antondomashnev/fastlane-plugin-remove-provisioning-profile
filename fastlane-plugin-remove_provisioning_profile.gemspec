# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/remove_provisioning_profile/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-remove_provisioning_profile'
  spec.version       = Fastlane::RemoveProvisioningProfile::VERSION
  spec.author        = %q{Anton Domashnev}
  spec.email         = %q{antondomashnev@gmail.com}

  spec.summary       = %q{Remove provision profile from your local machine}
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-remove_provisioning_profile"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.100.0'
end
