module Mkis
  class MaterialsController < BaseController
    include Uploadable
    before_action :set_search_params, only:[:index]
    before_filter :set_material, only: [:show]

    def index
      @q = current_store.store_material_saleinfos.ransack(params[:q])
      @store_materials = @q.result(distinct: true).order('id asc')

      respond_to do |format|
        format.json {
          render json: @store_materials.to_json
        }

        format.csv {}

        format.html {}
      end
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


    def set_material
      @store_material = current_store.store_materials.find(params[:id])
    end

    def set_search_params
      params[:q] ||= {}
      @root_categories = current_store.store_material_categories.super_categories.map{|root| [root.name, root.id]}
      @store_deports = current_store.store_depots.map{|deport| [deport.name, deport.id]}
      get_search_params
    end

    def get_search_params
      @root_category_id = params[:q][:store_material_store_material_root_category_id_eq]
      @sub_category_id = params[:q][:store_material_store_material_category_id_eq]
      @deport_id = params[:q][:store_material_store_material_inventories_store_depot_id_eq]
      @root_category = current_store.store_material_categories.where(id: @root_category_id).last
      if @root_category.present?
        @sub_categories = @root_category.sub_categories
      else
        @sub_categories = {}
      end
    end

  end
end
