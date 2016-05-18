module Import
  class StoreMaterialsService
    def initialize(store, staff, materials)
      @current_store = store
      @current_staff = staff
      @materials = materials
      import_all
    end

    def import_all
      @materials.each do |material|
        import(material[1])
      end
    end

    def import(material)
      @root_category = @current_store.store_material_categories.find_by_id(material[:root_category_id])
      if @root_category.blank? && material[:root_category_name].present?
        @root_category = @current_store.store_material_categories.find_or_create_by(name: material[:root_category_name]) do |root_category|
          root_category.store_chain_id = @current_store.store_chain_id
          root_category.store_staff_id = @current_staff.id
        end
      end
      if @root_category.present?
        @category = @root_category.sub_categories.find_by_id(material[:category_id]) 
        if @category.blank? && material[:category_name].present?
          @category = @root_category.sub_categories.find_or_create_by(name: material[:category_name]) do |category|
            category.store_id = @current_store.id
            category.store_chain_id = @current_store.store_chain_id
            category.store_staff_id = @current_staff.id
          end
        end
      else
        @category = nil
      end

      @unit = @current_store.store_material_units.find_by_id(material[:unit_id])
      if @unit.blank? && material[:unit_name].present?
        @unit = @current_store.store_material_units.find_or_create_by(name: material[:unit_name]) do |unit|
          unit.store_chain_id = @current_store.store_chain_id
        end
      end

      @brand = @current_store.store_material_brands.find_by_id(material[:brand_id])
      if @brand.blank? && material[:brand_name].present?
        @brand = @current_store.store_material_brands.find_or_create_by(name: params[:brand]) do |brand|
          brand.store_chain_id = @current_store.store_chain_id
          brand.store_staff_id = @current_staff.id
        end
      end

      @manufacturer = @current_store.store_material_manufacturers.find_by_id(material[:manufacture_id])
      if @manufacturer.blank? && material[:manufacture_name].present?
        @manufacturer = @current_store.store_material_manufacturers.find_or_create_by(name: material[:manufacture_name]) do |mf|
          mf.store_chain_id = @current_store.store_chain_id
          mf.store_staff_id = @current_staff.id
        end
      end

      @store_material = @current_store.store_materials.find_or_create_by(name: material[:name])
      if @store_material.new_record?
        @store_material.store_chain_id = @current_store.store_chain_id
        @store_material.store_staff_id = @current_staff.id
        @store_material.save
        @store_material.create_store_material_saleinfo({
          store_id: @current_store.id,
          store_chain_id: @current_store.store_chain_id,
          store_staff_id: @current_staff.id,
          retail_price: material[:retail_price]
        })
      else
        @store_material.store_material_saleinfo.update!(retail_price: material[:retail_price])
      end

      @store_material.barcode = material[:barcode]
      @store_material.speci = material[:speci]
      @store_material.cost_price = material[:cost_price]
      @store_material.permitted_to_saleable = material[:for_sell]
      @store_material.store_material_unit_id = @unit.id if @unit.present?
      @store_material.store_material_root_category_id = @root_category.id if @root_category.present?
      @store_material.store_material_category_id = @category.id if @category.present?
      @store_material.store_material_brand_id = @brand.id if @brand.present?
      @store_material.store_material_manufacturer_id = @manufacturer.id if @manufacturer.present?
      @store_material.save

      material[:depot].each do |name, quantity|
        depot = @current_store.store_depots.find_or_create_by(name: name) do |depot|
          depot.store_chain_id = @current_store.store_chain_id
          depot.store_staff_id = @current_staff.id
        end
        if quantity.present?
          inventory = @current_store.store_material_inventories.find_or_initialize_by(store_depot_id: depot.id, store_material_id: @store_material.id)
          inventory.store_staff_id = @current_staff.id if inventory.store_staff_id.blank?
          inventory.store_chain_id = @current_store.store_chain_id if inventory.store_chain_id.blank?
          inventory.save
          inventory.checkin!(quantity.to_f)
        end
      end

    end
  end
end
