class ScanTaskJob < ActiveJob::Base
  queue_as :default

  def perform
    StoreWorkstation.available
  end
end
