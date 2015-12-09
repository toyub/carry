class StoreMaterialTrackingSectionSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id,
             :store_material_id, :store_material_tracking_id,
             :timing, :delay_interval, :delay_unit, :delay_in_seconds,
             :contact_way, :content, :created_at, :updated_at
end
