class StoreSwitch < ActiveRecord::Base
  validates :switchable_id, presence: true
  validates :switchable_type, presence: true
end
