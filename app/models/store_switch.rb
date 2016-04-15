class StoreSwitch < ActiveRecord::Base
  include BaseModel
  validates :switchable_id, presence: true
  validates :switchable_type, presence: true

  scope :by_switchable_type, ->(type) { where(switchable_type: type) }
  scope :by_switchable_id, ->(id) { where(switchable_id: id) }
  scope :by_switchable, ->(switchable) { where(switchable_type: switchable.class.name, switchable_id: switchable.id)}

  SaleCategory = {
    "StoreService": 0,
    "StoreMaterialSaleinfo": 1,
    "StorePackage": 2,
  }

  def self.enabled?(type)
    by_switchable_id(SaleCategory[type.to_sym]).first.enabled
  end

  def switchable
    self.switchable_type.constantize.find(self.switchable_id)
  end

  def self.fetch_with_switch_and_operator(switchable, operator)
    switch = self.find_or_initialize_by(switchable_type: switchable.class.name,
                                    switchable_id: switchable.id,
                                    store_id: operator.store_id)
    if switch.store_staff_id.blank?
      switch.store_staff_id = operator.id
      switch.save!
    end
    switch
  end
end
