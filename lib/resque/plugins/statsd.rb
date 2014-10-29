module Resque
  module Plugins
    module Statsd

      # Note on Error handling:
      # Common cause of SocketErrors is failure of getaddrinfo (I.E. can't route to
      # statsd server or some such).  This may happen in development, when
      # your net connection isn't in a good way, for example.
      #
      # Ignoring all of them because we don't want unreachability of statsd to
      # impair the ability of an app to actually operate.

      def after_enqueue_statsd(*args)
        # TODO Why gauge is not supported @ jamster-statsd? :S
        Resqued.statsd.gauge("queues.#{@queue}.enqueued_elements", Resque.size(@queue)) # Elements by instant and queue
      rescue SocketError => se
        # Check note above (DRY)
      end

      def before_perform_statsd(*args)
        # TODO Send "element's time on queue"
      rescue SocketError => se
        # Check note above (DRY)
      end

      def after_perform_statsd(*args)
        # We're not measuring anything here
      rescue SocketError => se
        # Check note above (DRY)
      end

      def on_failure_statsd(exc, *args)
        # We're not measuring anything here
      rescue SocketError => se
        # Check note above (DRY)
      end

      def around_perform_statsd(exc, *args)
        retval = nil
        timing = Benchmark.measure do
          retval = yield
        end

        begin
          exc_name = exc.class.name.gsub('::', '-') # TODO: exc vs statsd_name? We want job's name
          Resqued.statsd.timing("jobs.#{statsd_name}.processed", (timing.real * 1000.0).round) # Perform time by job
        rescue SocketError => se
          # Check note above (DRY)
        end

        retval
      end

      def statsd_name
        @statsd_name ||= self.name.gsub('::', '-')
      end
    end
  end
end


