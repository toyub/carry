class Crm::StoreAssetsController < Crm::BaseController
  def index
    @customer = StoreCustomer.find(params[:store_customer_id])
    @deposit_card_items = @customer.store_deposit_cards_items
    @deposit_card_items_logs = @customer.store_deposit_cards_used_logs
    @packaged_service_items = @customer.store_packaged_service_items
    @taozhuang_items = @customer.store_taozhuang_items
    @patial = 'deposit_account'
  end

  def show
    @customer = StoreCustomer.find(params[:store_customer_id])
    @patial = params[:patial]

    respond_to do |format|
      format.js
    end
  end
end
