Gem::Specification.new do |s|
  s.name = 'resque-statsd'
  s.version = '0.1.0'
  s.author = 'Jason Amster'
  s.email = 'jayamster@gmail.com'
  s.summary = 'Resque Statsd is a Resque plugin that will collect and send data samples from your Resque Jobs to statsd'

  s.add_runtime_dependency('resque')
  s.add_runtime_dependency('statsd-ruby', '>= 0.3')
  s.add_development_dependency('rake')
  s.add_development_dependency('yard')
  s.add_development_dependency('rspec')

  s.files = Dir['lib/**/*']
  s.require_path = 'lib'
end

