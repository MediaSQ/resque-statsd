# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resque/gem_version'

Gem::Specification.new do |s|
  s.name         = 'resque-statsd'
  s.version      = Resque::GEM_VERSION
  s.author       = 'Jason Amster'
  s.email        = 'jayamster@gmail.com'
  s.summary      = 'Resque Statsd is a Resque plugin that will collect and send data samples from your Resque Jobs to statsd'

  s.files        = Dir['lib/**/*']
  s.require_path = 'lib'

  s.add_dependency 'resque'
  s.add_dependency 'statsd-ruby', '>= 0.3'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 1.3'
end

