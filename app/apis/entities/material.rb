module Entities
  class MaterialPhotoPath < Grape::Entity
    expose :file_url
  end
  class Material < Grape::Entity
    expose :id
    expose(:name) { |material, options| material.name }
    expose(:store_name) {|model| model.store.name}
    expose(:barcode) {|model| model.store_material_saleinfo.try(:barcode) }
    expose(:speci) {|model| model.store_material_saleinfo.try(:speci)}
    expose(:unit) { |material, options|  material.store_material_unit.try :name}
    expose(:retail_price) {|model| model.store_material_saleinfo.try(:retail_price)}
    expose(:bargain_price) {|model| model.store_material_saleinfo.try(:bargain_price) if model.store_material_saleinfo.try(:bargainable) == true }
    expose(:point) {|model| model.store_material_saleinfo.try(:point)}
    expose :inventory, :sold_count
    expose(:category) {|model| model.store_material_saleinfo.try(:category).try :name}
    expose :photo_path, using: MaterialPhotoPath

    def photo_path
      object.uploads
    end
  end
end
