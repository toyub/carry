class Kucun::StoreSupplierAssessmentsController < Kucun::BaseController
  def index
    @store = current_user.store
    @store_supplier = @store.store_suppliers.find(params[:store_supplier_id])
  end

end