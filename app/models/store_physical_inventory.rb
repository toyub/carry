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

# == Schema Information
#
# Table name: store_physical_inventories
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  store_depot_id :integer          not null
#  status         :integer          default(0)
#  created_month  :string(20)
#  created_at     :datetime
#  updated_at     :datetime
#
