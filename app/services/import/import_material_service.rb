module Import
  class ImportMaterialService
    def initialize(staff, cells, depots_names)
      @cells = cells
      @staff = staff
      @store = staff.store
      @depots_names = depots_names
      parse()
    end

    def save
      if validate
        if @material.save
          if @material.permitted_to_saleable
            @saleinfo = @material.build_store_material_saleinfo(retail_price: @retail_price.to_f, store_staff_id: @staff.id)
            @saleinfo.valid?
          else
            true
          end

          if @depots_names.present?
            @depots_names.each_with_index do |name, idx|
              depot = get_depot(name)
              inventory_quantity = @inventories[idx].try(:value).try(:strip)
              if inventory_quantity.present?
                inventory = StoreMaterialInventory.find_or_initialize_by(store_depot_id: depot.id,store_material_id: @material.id)
                if inventory.store_staff_id.blank?
                  inventory.store_staff_id = current_user.id
                  inventory.save
                end
                inventory.checkin!(inventory_quantity.to_f)
              end
            end
          end
          true
        else
          false
        end
      else
        false
      end
    end

    def validate
      if @name.blank?
        return false
      end

      if @store.store_materials.exists?(name: @name)
        return false
      end
      
      @material = @store.store_materials.new(material_attrs)
      @material.valid?
    end

    def material_attrs
      {        
        store_staff_id: @staff.id,
        store_material_root_category_id: @material_root_category.id,
        store_material_category_id: @material_category.id,
        store_material_unit_id: @material_unit.id,
        store_material_manufacturer_id: @material_manufacturer.id,
        store_material_brand_id: @material_brand.id,
        name: @name,
        barcode: @barcode,
        speci: @speci,
        cost_price: @cost_price.to_f,
        min_price: @cost_price.to_f,
        inventory_alarmify: false,
        expiry_alarmify:false,
        permitted_to_internal:true,
        permitted_to_saleable: saleable?
      }
    end

    private
    def parse
      @name               = @cells[0].try(:value).try(:strip)
      @bar_code           = @cells[1].try(:value).try(:strip)
      @root_category_name = @cells[2].try(:value).try(:strip)
      @category_name      = @cells[3].try(:value).try(:strip)
      @speci              = @cells[4].try(:value).try(:strip)
      @unit_name          = @cells[5].try(:value).try(:strip)
      @brand_name         = @cells[6].try(:value).try(:strip)
      @manufactor_name    = @cells[7].try(:value).try(:strip)
      @is_sale            = @cells[8].try(:value).try(:strip)
      @cost_price         = @cells[9].try(:value).try(:strip)
      @retail_price       = @cells[10].try(:value).try(:strip)
      @inventories        = @cells[11 .. -1]

      deal_category()
      deal_unit()
      deal_manufacturer()
      deal_brand()

    end

    def deal_category
      if @root_category_name.blank?
        @root_category_name = '缺省值'
      end

      if @category_name.blank?
        @category_name = '缺省值'
      end

      @material_root_category = @store.store_material_categories.find_by(name: @root_category_name)
      if @material_root_category.blank?
        @material_root_category = @store.store_material_categories.create(name: @root_category_name, store_staff_id: @staff.id, parent_id: 0)
      end
      @material_category = @material_root_category.sub_categories.find_by(name: @category_name)
      if @material_category.blank?
        @material_category = @material_root_category.sub_categories.create(name: @category_name, store_staff_id: @staff.id)
      end
      return @material_root_category, @material_category
    end


    def deal_unit
      if @unit_name.blank?
        @unit_name= '缺省值'
      end
      @material_unit = @store.store_material_units.find_by(name: @unit_name)
      if @material_unit.blank?
        @material_unit = @store.store_material_units.create(name: @unit_name, store_staff_id: @staff.id)
      end
      @material_unit
    end

    def deal_manufacturer
      if @manufactor_name.blank?
        @manufactor_name='缺省值'
      end
      @material_manufacturer = @store.store_material_manufacturers.find_by(name: @manufactor_name)
      if @material_manufacturer.blank?
        @material_manufacturer = @store.store_material_manufacturers.create(name: @manufactor_name, store_staff_id: @staff.id)
      end

      @material_manufacturer
    end

    def deal_brand
      if @brand_name.blank?
        @brand_name = '缺省值'
      end
      @material_brand = @store.store_material_brands.find_by(name: @brand_name)
      if @material_brand.blank?
        @material_brand = @store.store_material_brands.create(name: @brand_name, store_staff_id: @staff.id)
      end
      @material_brand
    end

    def saleable?
      @is_sale.to_s.include?('是') || @retail_price.to_f != 0.0
    end

    def get_depot(name)
      if name.blank?
        depot = @store.store_depots.current_preferred
      else
        depot = @store.store_depots.find_by(name: name)
        if depot.blank?
          depot = @store.store_depots.create(name: name, admin_ids: [@staff.id], store_staff_id: @staff.id)
        end
      end
      depot
    end
  end
end