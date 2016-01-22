module Entities
  class Material < Grape::Entity
    expose :id
    expose(:name) { |material, options| material.name }
    expose(:store_name) {|model| model.store.name}
    # expose :barcode
    # expose :speci
    # expose(:unit) { |material, options|  material.store_material.store_material_unit.try :name}
    # expose :retail_price
    # expose :bargain_price
    # expose :point
    # expose(:inventory) { |material, options| material.store_material.inventory }
    # expose :sold_count
    # expose(:category) { |material, options| material.category.try :name }

    private

      def sold_count
        500
      end
  end
end
