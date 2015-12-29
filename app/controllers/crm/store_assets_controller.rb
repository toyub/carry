class Crm::StoreAssetsController < Crm::BaseController
  def index
    @customer = StoreCustomer.find(params[:store_customer_id])
    @deposit_card_items = @customer.store_deposit_cards_items
    @deposit_card_items_logs = @customer.store_deposit_cards_used_logs
    @packaged_services = @customer.store_packaged_services
    @taozhuangs = @customer.store_taozhuangs
    @patial = 'deposit_records_wrap'
  end

  def show
    @customer = StoreCustomer.find(params[:store_customer_id])
    @partial = params[:partial] + "_records_wrap"
    @compose = params[:class_name].classify.constantize.find(params[:id])
    @items = @compose.items
    @current_item = @items.first

    respond_to do |format|
      format.js
    end
  end

  def detail
    @current_item = StoreCustomerAssetItem.find(params[:id])

    respond_to do |format|
      format.js
    end
  end
end
