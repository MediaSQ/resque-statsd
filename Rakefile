require 'rubygems'
require 'bundler/setup'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "resque-statsd"
  gem.homepage = "http://github.com/jamster/resque-statsd"
  gem.license = "MIT"
  gem.summary = %Q{Adds simple counters and timers for statsd into your Resque jobs}
  gem.description = %Q{Will add a counter for enqueuing, performing, failing and timing Jobs}
  gem.email = "jayamster@gmail.com"
  gem.authors = ["Jason Amster"]

  gem.add_runtime_dependency 'statsd-ruby', '~> 0.3'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rspec'
end
Jeweler::RubygemsDotOrgTasks.new

# require 'rspec/core'
# require 'rspec/core/rake_task'
# RSpec::Core::RakeTask.new(:spec) do |spec|
#   spec.pattern = FileList['spec/**/*_spec.rb']
# end
# 
# RSpec::Core::RakeTask.new(:rcov) do |spec|
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end
# 
# task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
