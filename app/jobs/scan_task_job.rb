class ScanTaskJob < ActiveJob::Base
  queue_as :default

  def perform
    StoreWorkstation.available.each do |workstation|
      workstation.dispatch
    end
  end
end
