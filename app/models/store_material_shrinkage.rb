class StoreMaterialShrinkage < ActiveRecord::Base
  include BaseModel
  
  has_many :items, class_name: 'StoreMaterialShrinkageItem'
  accepts_nested_attributes_for :items

  before_save :save_search_keys

  private
  def save_search_keys
    self.search_keys = self.items.map(&->(item){item.store_material.name}).join(',')
  end
end
