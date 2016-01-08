class SpotDispatchJob < ActiveJob::Base
  queue_as :default

  def perform(store_id)
    workstations = StoreWorkstation.of_store(store_id).idle
    workstations.each do |w|
      w.assign_workflow!
    end
  end
end
