class StoreCommissionTemplateSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id, :name,
             :aim_to, :aim_type, :confined_to, :confined_type, :mode_id, :mode_type, :sharing_enabled,
             :level_weight, :status, :created_at, :updated_at

  has_many :sections_attributes, serializer: 'StoreCommissionTemplateSectionSerializer'
  has_one  :mode0_section, serializer: 'StoreCommissionTemplateSectionSerializer'
  has_many :mode1_sections, serializer: 'StoreCommissionTemplateSectionSerializer'
  has_many :mode2_sections, serializer: 'StoreCommissionTemplateSectionSerializer'

  def sections_attributes
    object.sections
  end
end
