module Resque
  module Plugins
    module Statsd
      def after_enqueue_statsd(*args)
        Resqued.statsd.increment("queues.#{@queue}.enqueued")
        Resqued.statsd.increment("jobs.#{self.name}.enqueued")
        Resqued.statsd.increment("total.enqueued")
      rescue SocketError => se
        # Common cause of this is failure of getaddrinfo (I.E. can't route to
        # statsd server or some such).  This may happen in development, when
        # your net connection isn't in a good way, for example.
        #
        # Ignoring this because we don't want unreachability of statsd to
        # impair the ability of an app to actually operate.
      end

      def before_perform_statsd(*args)
        Resqued.statsd.increment("queues.#{@queue}.started")
        Resqued.statsd.increment("jobs.#{self.name}.started")
        Resqued.statsd.increment("total.started")
      rescue SocketError => se
        # Common cause of this is failure of getaddrinfo (I.E. can't route to
        # statsd server or some such).  This may happen in development, when
        # your net connection isn't in a good way, for example.
        #
        # Ignoring this because we don't want unreachability of statsd to
        # impair the ability of an app to actually operate.
      end

      def after_perform_statsd(*args)
        Resqued.statsd.increment("queues.#{@queue}.finished")
        Resqued.statsd.increment("jobs.#{self.name}.finished")
        Resqued.statsd.increment("total.finished")
      rescue SocketError => se
        # Common cause of this is failure of getaddrinfo (I.E. can't route to
        # statsd server or some such).  This may happen in development, when
        # your net connection isn't in a good way, for example.
        #
        # Ignoring this because we don't want unreachability of statsd to
        # impair the ability of an app to actually operate.
      end

      def on_failure_statsd(*args)
        Resqued.statsd.increment("queues.#{@queue}.failed")
        Resqued.statsd.increment("jobs.#{self.name}.failed")
        Resqued.statsd.increment("total.failed")
      rescue SocketError => se
        # Common cause of this is failure of getaddrinfo (I.E. can't route to
        # statsd server or some such).  This may happen in development, when
        # your net connection isn't in a good way, for example.
        #
        # Ignoring this because we don't want unreachability of statsd to
        # impair the ability of an app to actually operate.
      end

      def around_perform_statsd(*args)
        # We don't want to swallow a SocketError if it didn't actually come
        # from our attempts to talk to statsd.
        failure_is_in_app = true
        timing = Benchmark.measure { yield }
        Resqued.statsd.time("queues.#{@queue}.processed", (timing.real * 1000.0).round) do
          Resqued.statsd.time("jobs.#{self.name}.processed", (timing.real * 1000.0).round) do
            yield
            failure_is_in_app = false
          end
        end
      rescue SocketError => se
        # Common cause of this is failure of getaddrinfo (I.E. can't route to
        # statsd server or some such).  This may happen in development, when
        # your net connection isn't in a good way, for example.
        #
        # Ignoring this iff it's statsd-related because we don't want
        # unreachability of statsd to impair the ability of an app to actually
        # operate.
        raise se if(failure_is_in_app)
      end
    end
  end
end


