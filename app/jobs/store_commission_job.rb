class StoreCommissionJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    CheckMonthCommission.new.run
  end
end
