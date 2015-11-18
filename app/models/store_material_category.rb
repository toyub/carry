class StoreMaterialCategory < ActiveRecord::Base
  include BaseModel
  belongs_to :parent, class_name: 'StoreMaterialCategory', foreign_key: 'parent_id'
  has_many :sub_categories, class_name: 'StoreMaterialCategory', foreign_key: 'parent_id'

  scope :super_categories, ->(){where parent_id: 0}

  validates_presence_of :name

  def has_parent?
    self.parent_id.present? && self.parent_id > 0
  end

  def root?
    self.parent_id == 0
  end
end
