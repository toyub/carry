module Ajax
  class StoreSuppliersController < Ajax::BaseController
    respond_to :json, :js
    def index
      store_suppliers = current_store.store_suppliers.where("name like :keyword", "%#{params[:keyword]}%")
      respond_with store_suppliers
    end
  end
end
