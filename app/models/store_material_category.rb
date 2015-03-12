class StoreMaterialCategory < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
  belongs_to :parent, class_name: 'StoreMaterialCategory', foreign_key: 'parent_id'
  has_many :children, class_name: 'StoreMaterialCategory'
end
