class Crm::StoreAssetItemsController < Crm::BaseController
  def show
    @customer = StoreCustomer.find(params[:store_customer_id])
    @assets = @customer.assets.find(params[:store_asset_id])
    @item = @assets.items.find(params[:id])
    @logs = @item.logs
  end
end
