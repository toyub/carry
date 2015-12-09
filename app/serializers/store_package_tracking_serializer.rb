class StorePackageTrackingSerializer < ActiveModel::Serializer
  attributes :id, :mode, :notice_required, :content, :delay_unit, :delay_interval, :trigger_timing
end
