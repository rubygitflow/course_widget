class ForsingJob < ApplicationJob
  # queue_as :default
  # def self.queue
  #   :low_priority
  # end
  @queue = :default

  def perform(object)
  	puts("ForsingJob.perform")
    DeleteMock.start(object)
  end
end
