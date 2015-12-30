module Erp
  class StoresController < BaseController
    def index
      @stores = current_store_chain.stores
      respond_with @stores, location: nil
      
    end
  end
end
