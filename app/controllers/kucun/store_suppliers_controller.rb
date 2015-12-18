class Kucun::StoreSuppliersController < Kucun::BaseController
  def index
    @store = current_user.store
    @store_suppliers = @store.store_suppliers
  end

  def new
    @store_supplier = StoreSupplier.new
    render layout: 'tiny'
  end

  def add
    @store = current_user.store
    @store_supplier = StoreSupplier.new
  end

  def create
    store = current_user.store
    store_supplier = store.store_suppliers.new(supplier_params)
    store_supplier.store_chain_id = store.store_chain_id
    store_supplier.store_staff_id = current_user.id
    store_supplier.save

    if request.xhr?
      render json:store_supplier.to_json
    else
      respond_to do |format|
        format.html {redirect_to kucun_store_supplier_path(store_supplier)}
      end
    end
  end

  def edit
    @store = current_user.store
    @store_supplier = StoreSupplier.find(params[:id])
  end

  def update
    store_supplier = StoreSupplier.find(params[:id])
    store_supplier.update(supplier_params)
    redirect_to kucun_store_supplier_path(store_supplier)
  end

  def show
    @store_supplier = StoreSupplier.find(params[:id])
    @store = current_user.store
  end

  private
  def supplier_params
    params.require(:store_supplier).permit(:numero, :name, :mnemonic, :info_source_id, :weight_id,
                                           :contact_name, :contact_phone_number, :contact_tel_number, :contact_fax_number, :contact_email,
                                           :location_country_code, :location_state_code, :location_city_code, :location_address,
                                           :store_material_root_category_id, :store_material_category_id,
                                           :clearing_mode_id, :clearing_cycle_id, :clearing_day, :clearing_alarmify, :clearing_bank,
                                           :clearing_account, :clearing_vatin, :clearing_payment_method_id, :remark, :status)
  end
end
