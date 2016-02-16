class StorePackageTracking < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package

  def delay_until
    case delay_unit
    when 0
      delay_interval.minutes
    when 1
      delay_interval.hours
    when 2
      delay_interval.days
    when 3
      delay_interval.weeks
    when 4
      delay_interval.months
    end
  end
end
