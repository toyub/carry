class StoreMaterialPicking < ActiveRecord::Base
  attr_accessor :dest_depot_id
  belongs_to :sotre
  belongs_to :store_chain
  belongs_to :store_staff
  belongs_to :store_supplier
  has_many :items, class_name: 'StoreMaterialPickingItem'

  accepts_nested_attributes_for :items

  after_create :save_search_keys
  private
  def save_search_keys
    self.search_keys = self.items.map(&->(item){item.store_material.name}).join(',');
    self.save
  end
end
