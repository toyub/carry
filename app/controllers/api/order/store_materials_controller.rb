module Api
  module Order
    class StoreMaterialsController < BaseController
      before_action :get_plate, :get_category, only: [:show]
      before_action :get_sale_category, only: [:material_categories]
      def show
        respond_with @plate,@sale_category,@service_category, location: nil
      end

      def material_categories
        @sale_info = @store.store_material_saleinfos.where(sale_category_id: params[:sale_category_id])
        @materials = StoreMaterial.where(id: @sale_info.pluck(:store_material_id))
        respond_with @materials, location: nil
      end

      def search
        # params[:q] = {store_material_name_or_sale_category_name_cont: params[:name_cont]}
        @q = @store.store_material_saleinfos.ransack(params[:q])
        @materials = StoreMaterial.where(id: @q.result.pluck(:store_material_id))
        respond_with @materials, location: nil
      end

      private
      def get_customer
        @store_customer = StoreCustomer.find_by(params[:store_customer_id])
      end

      def get_category
        @sale_category = SaleCategory.all
        @service_category = ServiceCategory.all
      end

      def get_plate
        @plate = StoreVehicleRegistrationPlate.where(id: params[:plate_id]).last
      end

      def get_sale_category
        @material_category = SaleCategory.where(id: params[:sale_category_id]).last
      end
    end

  end
end
