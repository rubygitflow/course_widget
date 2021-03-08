class DailyCurrencyJob < ApplicationJob
  config.active_job.queue_adapter = :sidekiq

  queue_as :default

  def perform
  	DailyCurrency.update
  end
end
