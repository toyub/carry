class StorePhysicalInventory < ActiveRecord::Base
  include BaseModel
  has_many :items, class_name: 'StorePhysicalInventoryItem'
  belongs_to :store_depot

  enum status: %i[ pending checked ]

  before_save :set_created_month

  accepts_nested_attributes_for :items

  def checked_count
    self.items.count(:id)
  end

  def unchecked_count
    self.store_depot.material_types_count - self.checked_count
  end

  private
  def set_created_month
    if self.new_record?
      self.created_month = Time.now.strftime("%Y%m")
    end
  end
end
