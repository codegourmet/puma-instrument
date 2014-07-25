require 'statsd-instrument'
require 'get_process_mem'

module PumaInstrument
  extend self

  attr_accessor :statsd_backend, :statsd_path, :frequency
  self.frequency     = 10   # seconds
  self.statsd_backend = StatsD::Instrument::Backends::NullBackend.new
  self.statsd_path = 'request.memory.puma'

  def config
    yield self
  end

  def start
    StatsD.backend = self.statsd_backend
    ::PumaInstrument::AutoMemoryPoller.new(self.frequency, self.statsd_path).start
  end
end

require 'puma_instrument/auto_memory_poller'
require 'puma_instrument/memory_poller'
require 'puma_instrument/version'
