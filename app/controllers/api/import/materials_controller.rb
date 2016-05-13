module Api
  module Import
    class MaterialsController < Api::BaseController
      def index
        @materials = current_store.store_materials.select(:id, :name)
        render json: @materials.to_json
      end

      def create

        @root_category = current_store.store_material_categories.find_by_id(params[:material][:root_category_id])
        if @root_category.blank? && params[:root_category]
          @root_category = current_store.store_material_categories.find_or_create_by(name: params[:root_category]) do |root_category|
            root_category.store_chain_id = current_store.store_chain_id
            root_category.store_staff_id = current_staff.id
          end
        end
        @category = @root_category.sub_categories.find_by_id(params[:material][:category_id])
        if @category.blank? && params[:category]
          @category = @root_category.sub_categories.find_or_create_by(name: params[:category]) do |category|
            category.store_id = current_store.id
            category.store_chain_id = current_store.store_chain_id
            category.store_staff_id = current_staff.id
          end
        end

        @unit = current_store.store_material_units.find_by_id(params[:material][:unit_id])
        if @unit.blank? && params[:unit]
          @unit = current_store.store_material_units.find_or_create_by(name: params[:unit]) do |unit|
            unit.store_chain_id = current_store.store_chain_id
          end
        end

        @brand = current_store.store_material_brands.find_by_id(params[:material][:brand_id])
        if @brand.blank? && params[:brand]
          @brand = current_store.store_material_brands.find_or_create_by(name: params[:brand]) do |brand|
            brand.store_chain_id = current_store.store_chain_id
            brand.store_staff_id = current_staff.id
          end
        end

        @manufacturer = current_store.store_material_manufacturers.find_by_id(params[:material][:manufacture_id])
        if @manufacturer.blank? && params[:manufacture]
          @manufacturer = current_store.store_material_manufacturers.find_or_create_by(name: params[:manufacture]) do |mf|
            mf.store_chain_id = current_store.store_chain_id
            mf.store_staff_id = current_staff.id
          end
        end

        @store_material = current_store.store_materials.find_or_create_by(name: params[:material][:name])
        if @store_material.new_record?
          @store_material.store_chain_id = current_store.store_chain_id
          @store_material.store_staff_id = current_user.id
          @store_material.create_store_material_saleinfo({
            store_id: current_store.id,
            store_chain_id: current_store.store_chain_id,
            store_staff_id: current_staff.id,
            retail_price: params[:material][:retail_price]
          })
        else
          @store_material.store_material_saleinfo.update!(retail_price: params[:material][:retail_price])
        end

        @store_material.barcode = params[:material][:barcode]
        @store_material.speci = params[:material][:speci]
        @store_material.cost_price = params[:material][:cost_price],
        @store_material.permitted_to_saleable = params[:material][:for_sell]
        @store_material.store_material_unit_id = @unit.try(:id)
        @store_material.store_material_root_category_id = @root_category.try(:id)
        @store_material.store_material_category_id = @category.try(:id)
        @store_material.store_material_brand_id = @brand.try(:id)
        @store_material.store_material_manufacturer_id = @manufacturer.try(:id)
        @store_material.save

        params[:material][:depot].each do |name, quantity|
          depot = current_store.store_depots.find_or_create_by(name: name) do |depot|
            depot.store_chain_id = current_store.store_chain_id
            depot.store_staff_id = current_staff.id
          end
          if quantity.present?
            inventory = current_store.store_material_inventories.find_or_initialize_by(store_depot_id: depot.id,store_material_id: @store_material.id)
            inventory.store_staff_id = current_staff.id if inventory.store_staff_id.blank?
            inventory.store_chain_id = current_store.store_chain_id if inventory.store_chain_id.blank?
            inventory.save
            inventory.checkin!(quantity.to_f)
          end
        end

        render json: {success: true}
      end
    end
  end
end
