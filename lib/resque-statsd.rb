require 'rubygems'
require 'benchmark'
require 'statsd'
require 'resque/plugins/statsd'
require 'resque'

# Set up the client
$resque_statsd = Statsd.new(ENV['STATSD_HOST'], ENV['STATSD_PORT'])
$resque_statsd.namespace="#{ENV['APP_NAME']}_#{ENV['RAILS_ENV']}.resque"

module Resque
  class << self
    alias_method :push_without_timestamps, :push
    def push(queue, item)
      if item.respond_to?(:[]=)
        item[:created_at] = Time.now.to_f
      end
      push_without_timestamps queue, item
    end
  end

  class Job
    def initialize(queue, payload)
      @queue = queue
      @payload = payload
      if $resque_statsd && @payload["created_at"]
        $resque_statsd.timing "#{@queue}.queue_time", (1000 * (Time.now.to_f - @payload["created_at"].to_i)).round
        $resque_statsd.timing "#{payload_class}.queue_time", (1000 * (Time.now.to_f - @payload["created_at"].to_i)).round
      end
    end
  end

  module Plugins
    module Statsd
      VERSION = "0.1.0"
    end
  end
end
