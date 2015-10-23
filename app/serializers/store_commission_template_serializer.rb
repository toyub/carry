class StoreCommissionTemplateSerializer < ActiveModel::Serializer
  attributes :id, :name, :aim_to, :confined_to, :mode_id, :sections_attributes, :level_weight, :status

  def sections_attributes
    object.sections
  end
end
