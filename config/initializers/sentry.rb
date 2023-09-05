Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN')
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  config.enabled_environments = %w[production]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 0.5

  config.delayed_job.report_after_job_retries = true
  config.sidekiq.report_after_job_retries = true
end
