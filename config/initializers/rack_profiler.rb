if Rails.env.development? || Rails.env.sandbox?
  require 'rack-mini-profiler'

  # Initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)

  # Needed for staging env
  Rack::MiniProfiler.config.pre_authorize_cb = lambda { |env| true }
  Rack::MiniProfiler.config.authorization_mode = :allowall
end
