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

# == Schema Information
#
# Table name: store_material_categories
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  parent_id      :integer          default(0), not null
#  name           :string(45)
#  created_at     :datetime
#  updated_at     :datetime
#
