# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subexec/notifications/version'

Gem::Specification.new do |spec|
  spec.name          = 'subexec-notifications'
  spec.version       = Subexec::Notifications::VERSION
  spec.authors       = ['Ken Collins']
  spec.email         = ['ken@metaskills.net']
  spec.summary       = 'Instrumentation For Subexec Commands Using ActiveSupport::Notifications'
  spec.description   = spec.summary
  spec.homepage      = 'http://github.com/customink/subexec-notifications'
  spec.license       = 'MIT'
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_runtime_dependency     'subexec'
  spec.add_runtime_dependency     'activesupport', '>= 3.0'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
end
