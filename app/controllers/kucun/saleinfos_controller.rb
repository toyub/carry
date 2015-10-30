class Kucun::SaleinfosController < Kucun::ControllerBase

  def new
    @store = current_user.store
    @store_material = StoreMaterial.find(params[:material_id])
    @sale_info = @store_material.store_material_saleinfo
    if @sale_info.present?
      redirect_to edit_kucun_material_saleinfo_path(@store_material)
      return
    end
    @sale_info = StoreMaterialSaleinfo.new
    @store_material_saleinfo_category = StoreMaterialSaleinfoCategory.where(store_material_category_id: @store_material.store_material_category.id).first ||
                                        StoreMaterialSaleinfoCategory.create(store_material_category_id: @store_material.store_material_category.id,
                                                                             name: @store_material.store_material_category.name,
                                                                             store_id: current_user.store_id,
                                                                             store_chain_id: current_user.store_chain_id,
                                                                             store_staff_id: current_user.id)
    @store_material_saleinfo_categories = StoreMaterialSaleinfoCategory.all
    @store_commission_templates = StoreCommissionTemplate.where(status: 0)
  end

  def create
    @store = current_user.store
    @store_material = StoreMaterial.find(params[:material_id])
    if @store_material.store_material_saleinfo.present?
      if request.xhr?
        render json: {msg: 'Already saved, please update!'}
      else
        redirect_to action: 'show'
      end
      return false
    end
    saleinfo = @store_material.build_store_material_saleinfo(saleinfo_params)
    saleinfo.store_staff_id = current_user.id
    saleinfo.services.each do |service|
      service.store_material_id = @store_material.id
      service.store_staff_id = saleinfo.store_staff_id
    end

    saleinfo.save!

    render json: {
      saleinfo: saleinfo,
      services_attributes: saleinfo.services
    }
  end

  def edit
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @sale_info = @store_material.store_material_saleinfo
    if @sale_info.blank?
      redirect_to action: "new"
    end
  end

  def update
  end

  def show

     @store = current_user.store
     @store_material = @store.store_materials.find(params[:material_id])
     @sale_info = @store_material.store_material_saleinfo
     if @sale_info.blank?
       redirect_to action: "new"
     end
  end

  private
  def saleinfo_params
    params.require(:saleinfo).permit :id, :bargainable, :bargain_price, :retail_price, :trade_price, :reward_points,
                                     :divide_to_retail, :unit, :volume, :service_needed, :service_fee_needed,
                                     :service_fee,:saleman_commission_template_id,
                                     services_attributes: [:id, :store_commission_template_id, :name, :mechanic_level, :work_time,
                                                           :work_time_unit, :work_time_in_seconds, :tracking_needed, :tracking_delay,
                                                           :tracking_delay_unit, :tracking_delay_in_seconds, :tracking_contact_way,
                                                           :tracking_content, :mechanic_commission_template_id]
  end
end
