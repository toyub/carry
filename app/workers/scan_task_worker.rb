class ScanTaskWorker
  include Sidekiq::Worker

  def perform
    ScanTaskJob.perform_now
  end

end
