module Entities
  class StoreMaterialSaleinfoService < Grape::Entity
    expose :name, :work_time, :quantity, :mechanic_level, :store_material_id,
           :store_material_saleinfo_id, :mechanic_level_type
    expose(:material_service_id){|model|model.id}
  end

  class MaterialPhotoPath < Grape::Entity
    expose :file_url
  end

  class Material < Grape::Entity
    expose :id, if: {type: :default}
    expose(:store_material_id, if: {type: :full}) {|model|model.store_material_id}
    expose(:store_material_saleinfo_id, if: {type: :full}) {|model|model.id}
    expose(:name, if: {type: :default}) { |material, options| material.name }
    expose(:name, if: {type: :full}) {|model|model.store_material.name}
    expose(:store_name, if: {type: :default}) {|model| model.store.name}
    expose(:store_name, if: {type: :full}) {|model|model.store.name}
    expose(:barcode, if: {type: :default}) {|model| model.store_material_saleinfo.try(:barcode) }
    expose(:speci, if: {type: :default}) {|model| model.store_material_saleinfo.try(:speci)}
    expose(:unit, if: {type: :default}) { |material, options|  material.store_material_unit.try :name}
    expose(:unit, if: {type: :full}) {|model| model.store_material.store_material_unit.try :name}
    expose(:retail_price, if: {type: :default}) {|model| model.store_material_saleinfo.try(:retail_price)}
    expose(:bargain_price, if: {type: :default}) {|model| model.store_material_saleinfo.try(:bargain_price) if model.store_material_saleinfo.try(:bargainable) == true }
    expose(:point, if: {type: :default}) {|model| model.store_material_saleinfo.try(:point)}
    expose :inventory, :sold_count, if: {type: :default}
    expose(:inventory, if: {type: :full}) {|model|model.store_material.inventory}
    expose(:sold_count, if: {type: :full}) {|model|model.store_material.sold_count}
    expose(:category, if: {type: :default}) {|model| model.store_material_saleinfo.try(:category).try :name}
    expose(:category, if: {type: :full}) {|model|model.try(:category).try(:name)}
    expose :photo_path, using: MaterialPhotoPath, if: {type: :default}
    expose :picture_path, using: MaterialPhotoPath, if: {type: :full}
    expose :material_service, using: StoreMaterialSaleinfoService, if: {type: :default}
    expose :services, using: StoreMaterialSaleinfoService, if: {type: :full}
    expose :barcode, :speci, :retail_price, :bargain_price, :bargainable,
          :point, if: {type: :full}

    def photo_path
      object.uploads
    end

    def picture_path
      object.store_material.uploads
    end

    def material_service
      object.store_material_saleinfo.try(:services)
    end
  end
end
