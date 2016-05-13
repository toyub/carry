module Api
  module Import
    class MaterialsController < Api::BaseController
      def index
        @materials = current_store.store_materials.select(:id, :name)
        render json: @materials.to_json
      end

      def create

        @root_category = current_store.store_material_categories.find_or_create_by(id: params[:material][:root_category_id]) do |root_category|
          root_category.store_chain_id = current_store.store_chain_id
          root_category.store_staff_id = current_staff.id
          root_category.name = params[:root_category]
        end
        @category = @root_category.sub_categories.find_or_create_by(id: params[:material][:category_id]) do |caetgory|
          category.store_id = current_store.id
          category.store_chain_id = current_store.store_chain_id
          category.store_staff_id = current_staff.id
          category.name = params[:root_category]
        end
        @unit = current_store.store_material_units.find_or_create_by(id: params[:material][:unit_id]) do |unit|
          unit.store_chain_id = current_store.store_chain_id
          unit.name = params[:unit]
        end
        @brand = current_store.store_material_brands.find_or_create_by(name: params[:material][:brand]) do |brand|
          brand.store_chain_id = current_store.store_chain_id
          brand.store_staff_id = current_staff.id
          brand.name = params[:material][:brand]
        end
        @manufacturer = current_store.store_material_manufacturers.find_or_create_by(name: params[:material][:brand]) do |mf|
          mf.store_chain_id = current_store.store_chain_id
          mf.store_staff_id = current_staff.id
          mf.name = params[:material][:manufacture]
        end

        @store_material = current_store.store_materials.find_or_create_by(name: params[:material][:name])
        @store_material.store_chain_id = current_store.store_chain_id
        @store_material.store_staff_id = current_user.id
        @store_material.barcode = params[:material][:barcode]
        @store_material.speci = params[:material][:speci]
        @store_material.permitted_to_saleable = params[:material][:for_sell]
        @store_material.store_material_unit_id = @unit.id
        @store_material.store_material_root_category_id = @root_category.id
        @store_material.store_material_category_id = @category.id
        @store_material.store_material_brand_id = @brand.id
        @store_material.store_material_manufacturer_id = @manufacturer.id
        @store_material.save
        @store_material.create_store_material_saleinfo({
          store_id: current_store.id,
          store_chain_id: current_store.store_chain_id,
          store_staff_id: current_staff.id,
          cost_price: params[:material][:cost_price],
          retail_price: params[:material][:retail_price]
        })

        params[:material][:depot].each do |name, quantity|
          @depost = current_store.store_depots.find_or_create_by(name: name)
        end

        render json: {success: true}
      end
    end
  end
end
