class StorePackageSettingSerializer < ActiveModel::Serializer
  attributes :id, :retail_price, :period_enable, :period_unit, :period, :expired_notice_required, :before_expired, :apply_range, :point, :payment_mode, :store_commission_template_id
end
