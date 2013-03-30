require 'rubygems'
require 'statsd' # Really Jnunemakers's mine branch of statsd 
require 'resque/plugins/statsd'

# Set up the client
$resque_statsd = Statsd.new(ENV['STATSD_HOST'], ENV['STATSD_PORT'])
$resque_statsd.namespace="#{ENV['APP_NAME']}_#{ENV['RAILS_ENV']}.resque"


module Resque
  module Plugins
    module Statsd

      VERSION = "0.0.1"
      
    end
  end
end
