class StorePhysicalInventory < ActiveRecord::Base
  include BaseModel
  has_many :items, class_name: 'StorePhysicalInventoryItem'
  belongs_to :store_depot

  before_save :set_created_month

  accepts_nested_attributes_for :items

  private
  def set_created_month
    if self.new_record?
      self.created_month = Time.now.strftime("%Y%m")
    end
  end
end
