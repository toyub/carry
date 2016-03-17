module Entities
  class SaleMaterial < Grape::Entity
    expose :id, :name, :barcode, :speci, :bargainable, :point,
           :retail_price, :bargain_price, :sold_count, :vip_price,
           :vip_price_enabled
    expose(:store_name) {|model| model.store.name}
    expose(:unit) {|model| model.store_material.store_material_unit.try :name}
    expose(:inventory) {|model|model.store_material.inventory}
    expose(:category) {|model|model.try(:category).try(:name)}
    expose :photo_path, using: MaterialPhotoPath
    expose :services, using: StoreMaterialSaleinfoService

    def photo_path
      object.store_material.uploads
    end
  end
end
