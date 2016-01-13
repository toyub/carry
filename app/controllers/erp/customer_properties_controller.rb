module Erp
  class CustomerPropertiesController < BaseController
    def index
      @properties = StoreCustomerEntity::PROPERTIES
      respond_with @properties, location: nil
    end
  end
end
