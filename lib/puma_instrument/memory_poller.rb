module PumaInstrument
  class MemoryPoller

    def initialize(statsd_path)
      @statsd_path = statsd_path
    end

    def poll
      memory_used = get_puma_memory
      unless memory_used.nil?
        log_memory_used(memory_used)
      end
    end

    protected

      def get_puma_memory
        return nil unless defined?(Puma::Cluster)
        master = ObjectSpace.each_object(Puma::Cluster).map { |obj| obj }.first
        return nil if !master

        workers = master.instance_variable_get("@workers") || []
        return nil if workers.empty?

        sum_worker_memory(workers)
      end

      def sum_worker_memory(workers)
        workers.inject(0) do |result, worker|
          memory = GetProcessMem.new(worker.pid).mb
          result + memory
        end
      end

      def log_memory_used(memory_used)
        StatsD.measure(@statsd_path, memory_used)
      end

  end
end
