class StoreServiceTracking < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service

  def delay_until
  case 
    delay_interval.minutes
    delay_interval.hours
    delay_interval.days
    delay_interval.weeks
    delay_interval.months
  end

end
