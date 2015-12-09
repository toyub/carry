class StoreMaterialTrackingSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id,
             :store_material_id, :enabled, :tracking_mode,
             :reminder_required, :created_at, :updated_at

  has_many :sections_attributes, serializer: 'StoreMaterialTrackingSectionSerializer'

  def sections_attributes
   object.sections
  end
end
