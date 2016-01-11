module Erp
  class StoresController < BaseController
    def index
      @stores = current_store_chain.stores
      respond_with @stores, location: nil
    end

    def organization
      store = current_store_chain.stores.find(params[:id])
      @organ = store.present? ? StoreOrganizationSerializer.new(store).data : {}
      render json: @organ
    end
  end
end
