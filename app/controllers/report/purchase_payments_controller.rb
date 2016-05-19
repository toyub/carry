module Report
  class PurchasePaymentsController < BaseController
    def index
      @material_order_payments = current_store.store_material_order_payments
    end
  end
end
