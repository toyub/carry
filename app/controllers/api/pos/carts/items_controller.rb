module Api
  module Pos
    module Carts
      class ItemsController < Api::BaseController
        def show
          render json: {}
        end

        def destroy
          order = current_store.store_orders.find(params[:order_id])
          item = order.items.find(params[:id])
          if item.orderable.is_a?(StoreMaterialSaleinfo) || item.orderable.is_a?(StorePackage)
            order.items.where(package_type: item.orderable.class.name, package_id: item.orderable.id).each do |sub_item|
              sub_item.destroy_related_workflows
              sub_item.destroy!
            end
          end
          item.destroy_related_workflows
          item.destroy!
          respond_with item,location: nil
        end
      end
    end
  end
end
