module Entities
  class Material < Grape::Entity
    expose :id
    expose(:name) { |material, options| material.name }
    expose(:store_name) {|model| model.store.name}
    expose(:barcode) {|model| model.store_material_saleinfo.try(:barcode) }
    expose(:speci) {|model| model.store_material_saleinfo.try(:speci)}
    expose(:unit) { |material, options|  material.store_material_unit.try :name}
    expose(:retail_price) {|model| model.store_material_saleinfo.try(:retail_price)}
    expose(:bargain_price) {|model| model.store_material_saleinfo.try(:bargain_price)}
    expose(:point) {|model| model.store_material_saleinfo.try(:point)}
    expose :inventory
    expose :sold_count
    expose(:category) {|model| model.store_material_saleinfo.try(:category).try :name}

    private

      def sold_count
        500
      end
  end
end
