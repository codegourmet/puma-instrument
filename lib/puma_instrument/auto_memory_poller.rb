module PumaInstrument
  class AutoMemoryPoller

    def initialize(timeout, statsd_path)
      @timeout = timeout # seconds
      @poller = MemoryPoller.new(statsd_path)
      @running = false
      @statsd_path = statsd_path
    end

    def start
      @running = true

      Thread.new do
        while @running
          @poller.poll
          sleep @timeout
        end
      end
    end

  end
end
