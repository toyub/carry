class SetStaffRegularJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StoreStaff.unregular.each {|staff| staff.update(regular: true) if staff.could_regular? }
  end
end
