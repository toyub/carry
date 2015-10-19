class StoreServiceTrackingSerializer < ActiveModel::Serializer
  attributes :id, :content, :mode, :delay_interval, :delay_unit, :notice_required, :trigger_timing, :store_service_id

end
