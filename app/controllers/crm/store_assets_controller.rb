class Crm::StoreAssetsController < Crm::BaseController
  def index
    @customer = StoreCustomer.find(params[:store_customer_id])
    @deposit_card_assets = @customer.deposit_cards_assets
    @deposit_card_items_logs = @customer.deposit_logs
    @packaged_assets = @customer.packaged_assets
    @taozhuang_assets = @customer.taozhuang_assets
  end

  def show
    @customer = StoreCustomer.find(params[:store_customer_id])
    @composition = @customer.assets.find(params[:id]) 
    @items = @composition.items
    @logs = @items.first.logs
  end

end
