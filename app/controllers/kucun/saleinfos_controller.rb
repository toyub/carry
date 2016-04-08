class Kucun::SaleinfosController < Kucun::BaseController
  before_action :set_material_info, only: [:show, :edit]

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
      material_id: @store_material.id,
      saleinfo: saleinfo,
      services_attributes: saleinfo.services
    }
  end

  def update
    @store = current_user.store
    @store_material = StoreMaterial.find(params[:material_id])
    if @store_material.store_material_saleinfo.blank?
      render json: {msg: 'No saleinfo found, use create'}
      return false
    end
    saleinfo = @store_material.store_material_saleinfo
    safe_params = saleinfo_params
    if safe_params[:services_attributes]
      safe_params[:services_attributes].each do |idx, service|
        if service[:store_staff_id].blank?
          service[:store_staff_id] = current_user.id
          service[:store_id] = current_store.id
          service[:store_chain_id] = current_store.store_chain_id
        end
      end
    end
    saleinfo.update!(safe_params)
    render json: {
      material_id: @store_material.id,
      saleinfo: saleinfo,
      services_attributes: saleinfo.services
    }
  end

  def edit
  end

  def show
    if @saleinfo.new_record?
      render :edit
      return
    end
  end

  private
  def saleinfo_params
    params.require(:saleinfo).permit :id, :bargainable, :bargain_price, :retail_price, :trade_price, :reward_points,
                                     :divide_to_retail, :divide_unit_type_id, :divide_total_volume, :divide_volume_per_bill,
                                     :service_needed, :service_fee_needed, :sale_category_id,
                                     :service_fee,:saleman_commission_template_id, :vip_price_enabled, :vip_price,
                                     services_attributes: [:id, :store_commission_template_id, :name, :mechanic_level, :work_time,
                                                           :work_time_unit, :work_time_in_seconds, :tracking_needed, :tracking_delay,
                                                           :tracking_delay_unit, :tracking_delay_in_seconds, :tracking_contact_way,
                                                           :tracking_content, :mechanic_commission_template_id, :quantity]
  end

  def set_material_info
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @saleinfo = @store_material.store_material_saleinfo
    if @saleinfo.blank?
      @saleinfo = StoreMaterialSaleinfo.new
    end
    @sale_categories = SaleCategory.all
    @store_commission_templates = current_store.store_commission_templates.available.for_saleman
  end
end
