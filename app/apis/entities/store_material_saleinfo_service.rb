module Entities
  class StoreMaterialSaleinfoService < Grape::Entity
    expose :name, :work_time, :quantity, :mechanic_level, :store_material_id,
           :store_material_saleinfo_id, :mechanic_level_type
    expose(:material_service_id){|model|model.id}
  end
end
