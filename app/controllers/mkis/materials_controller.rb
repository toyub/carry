module Mkis
  class MaterialsController < BaseController
    include Uploadable
    before_action :get_type, only:[:index]
    before_filter :set_material, only: [:show, :edit]

    def index
      @store_materials = current_store.store_material_saleinfos.order('id asc')

      if params[:root_category_id].present?
        @root_category = @store.store_material_categories.find(params[:root_category_id])
      end

      respond_to do |format|
        format.json {
          render json: @store_materials.to_json
        }

        format.csv {}

        format.html {}
      end
    end

    def new
      @store = current_user.store
      @store_material = @store.store_materials.new
    end

    def create
      store = current_store
      store_material = store.store_materials.build(material_params)
      store_material.store_staff_id=current_user.id
      store_material.save!
      render json: store_material, root: nil
    end

    def edit
      @store = current_store
    end

    def update
      store = current_store
      store_material = store.store_materials.find(params[:id])
      store_material.update!(material_params)
      # redirect_to mkis_material_saleinfo_path(store_material)
      render json: store_material, root: nil
    end

    def show
      if @store_material.permitted_to_saleable && @store_material.store_material_saleinfo.blank?
        redirect_to edit_kucun_material_saleinfo_path(material_id: @store_material.id)
        return
      end
    end

    def autocomplete_name
      result = StoreMaterial.where('name like :name', name: "%#{params[:q]}%").map(&:name)
      render text: "#{params[:callback]}(#{result.to_json})"
    end

    private
    def resource
      @store_material ||= set_material
    end

    def material_params
      params.require(:material).permit(:store_material_root_category_id, :store_material_category_id, :store_material_unit_id,
                                       :store_material_manufacturer_id, :store_material_brand_id,
                                       :name, :speci, :barcode, :mnemonic,
                                       :min_price, :cost_price,
                                       :inventory_alarmify, :max_inventory, :min_inventory,
                                       :expiry_alarmify, :shelf_life, :permitted_to_internal,
                                       :permitted_to_saleable, :remark, :introduction)
    end

    def set_material
      @store_material = current_store.store_materials.find(params[:id])
    end

    def get_type
      @type = params[:type] if params[:type]
    end
  end
end
