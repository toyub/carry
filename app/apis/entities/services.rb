module Entities
  class Services < Grape::Entity
    expose :id, :name, :code, :retail_price, :bargain_price, :point, :mechanic_levles, :saled, :category, :time, :store_name
    expose(:unit) {|model| model.unit.try(:name)}
  end
end
