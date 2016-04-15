class StoreCommissionJob < ActiveJob::Base
  queue_as :default

  def perform(month = nil)
    CheckMonthCommission.new(month).run
  end
end
