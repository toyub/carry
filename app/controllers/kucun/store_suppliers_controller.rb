class Kucun::StoreSuppliersController < Kucun::ControllerBase
  def new
    @store_supplier = StoreSupplier.new
    render layout: 'tiny'
  end

  def create
    store = current_user.store
    store_supplier = store.store_suppliers.new(supplier_params)
    store_supplier.store_chain_id = store.store_chain_id
    store_supplier.store_staff_id = current_user.id
    store_supplier.save
    render json: store_supplier
  end

  private
  def supplier_params
    params.require(:store_supplier).permit(:name)
  end
end