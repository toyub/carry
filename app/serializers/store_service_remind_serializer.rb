class StoreServiceRemindSerializer < ActiveModel::Serializer
  attributes :id, :content, :mode, :delay_interval, :enable, :notice_required, :trigger_timing, :store_service_id

end
