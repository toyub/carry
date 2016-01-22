module Entities
  class Material < Grape::Entity
    expose :id
    expose(:name) { |material, options| material.name }
    expose(:store_name) {|model| model.store.name}
    expose(:barcode, if: :full) {|model| saleinfo(model, barcode)}
    expose(:speci, if: :full) {|model| saleinfo(model,speci)}
    expose(:unit) { |material, options|  material.store_material_unit.try :name}
    expose(:retail_price, if: :full) {|model| saleinfo(model,retail_price)}
    expose(:bargain_price, if: :full) {|model| saleinfo(model, bargain_price)}
    expose(:point, if: :full) {|model| saleinfo(model, point)}
    expose :inventory
    expose :sold_count
    # expose(:category) { |material, options| material.category.try :name }
    expose(:category, if: :full) {|model| model.store_material_saleinfo.category.try :name}

    private

      def sold_count
        500
      end

      def full
        object.store_material_saleinfo.present?
      end

      def saleinfo(model,info)
        model.store_material_saleinfo.info
      end
  end
end
