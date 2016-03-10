module Entities
  class StoreMaterialSaleinfoService < Grape::Entity
    expose :name, :work_time, :quantity, :mechanic_level, :store_material_id,
           :store_material_saleinfo_id, :mechanic_level_type
    expose(:material_service_id){|model|model.id}
  end

  class MaterialPhotoPath < Grape::Entity
    expose :file_url
  end

  class SaleMaterial < Grape::Entity
    expose :id, :name, :barcode, :speci, :bargainable, :point,
           :retail_price, :bargain_price
    expose(:store_name) {|model| model.store.name}

    expose(:unit) {|model| model.store_material.store_material_unit.try :name}

    expose(:inventory) {|model|model.store_material.inventory}
    expose(:sold_count) {|model|model.store_material.sold_count}
    expose(:category) {|model|model.try(:category).try(:name)}
    expose :photo_path, using: MaterialPhotoPath

    expose :services, using: StoreMaterialSaleinfoService


    def photo_path
      object.store_material.uploads
    end
  end
end
