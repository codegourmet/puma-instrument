Simple statsd wrapper to be used inside puma config, monitoring memory consumption of workers.
Use with https://github.com/Shopify/statsd-instrument
Puma config recipe from: https://github.com/schneems/puma_worker_killer/issues/5

Example puma.erb excerpt:

    require 'statsd-instrument'

    worker_initialized = false

    after_worker_boot do
      unless worker_initialized
        worker_initialized = true

        PumaInstrument.config do |config|
          config.statsd_backend = StatsD::Instrument::Backends::UDPBackend.new(
            YOUR_STATSD_BACKEND_URL_WITH_UDP_PORT, :statsd
          )
          config.frequency = 5 # seconds
          config.statsd_path = 'request.memory.puma'
        end

        PumaInstrument.start
      end
    end


Credits: most stuff in here is taken from puma_worker_killer:
https://github.com/schneems/puma_worker_killer

TODO very first version, no tests yet, not fully gemified, no commentationings.
USE AT YOUR OWN RISK
