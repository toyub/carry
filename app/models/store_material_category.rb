class StoreMaterialCategory < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
  belongs_to :parent, class_name: 'StoreMaterialCategory', foreign_key: 'parent_id'
  has_many :sub_categories, class_name: 'StoreMaterialCategory', foreign_key: 'parent_id'

  scope :super_categories, ->(){where parent_id: 0}

  def has_parent?
    self.parent_id.present? && self.parent_id > 0
  end

  def root?
    self.parent_id == 0
  end
end
