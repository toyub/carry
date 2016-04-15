module Entities
  class Service < Grape::Entity
    expose :id, :name, :code, :retail_price, :bargain_price, :point,
           :mechanic_levles, :saled, :category, :time, :store_name,
           :vip_price_enabled, :bargain_price_enabled
    expose(:unit) {|model| model.unit.try(:name)}
  end
end
