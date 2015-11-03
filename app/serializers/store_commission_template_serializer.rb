# == Schema Information
#
# Table name: store_commission_templates
#
#  id                :integer          not null, primary key
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  name              :string(45)
#  aim_to            :integer
#  confined_to       :integer
#  mode_id           :integer
#  level_weight_hash :string(100)
#  status            :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#

class StoreCommissionTemplateSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id, :name,
             :aim_to, :aim_type, :confined_to, :confined_type, :mode_id, :mode_type,
             :level_weight, :status, :created_at, :updated_at

  has_many :sections_attributes, serializer: 'StoreCommissionTemplateSectionSerializer'
  has_one  :mode0_section, serializer: 'StoreCommissionTemplateSectionSerializer'
  has_many :mode1_sections, serializer: 'StoreCommissionTemplateSectionSerializer'
  has_many :mode2_sections, serializer: 'StoreCommissionTemplateSectionSerializer'

  def sections_attributes
    object.sections
  end
end
