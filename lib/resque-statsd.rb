require 'rubygems'
require 'benchmark'
require 'statsd'
require 'resque/plugins/statsd'
require 'resque'

class Resqued
  def self.graphite_host
    return @graphite_host || ENV['GRAPHITE_HOST'] || 'localhost'
  end

  def self.graphite_host=(val)
    @graphite_host = val
  end

  def self.graphite_port
    return @graphite_port || ENV['GRAPHITE_PORT'] || 8125
  end

  def self.graphite_port=(val)
    @graphite_port = val
  end

  def self.namespace
    return @namespace || ENV['GRAPHITE_NAMESPACE'] || 'resque'
  end

  def self.namespace=(val)
    @namespace = val
  end

  def self.logger
    @logger ||= if defined?(Rails)
                  Rails.logger
                else
                  require 'logger'
                  Logger.new($stderr)
                end
  end

  def self.logger=(val)
    @logger = val
  end

  # Set up the client lazily, to minimize order-of-operations headaches.
  def self.statsd
    @statsd ||= initialize_statsd
  end

  def self.initialize_statsd
    Statsd.new(graphite_host, graphite_port).tap do |statsd|
      statsd.namespace = namespace
    end
  end
end

module Resque
  module Plugins
    module Statsd
      VERSION = '0.1.5'
    end
  end
end
