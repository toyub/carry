module Api
  class StorePackagesController < BaseController
    include Uploadable

    before_action :set_package, except: [:create, :index]

    def index
      @q = current_store.store_packages.ransack(params[:q])
      @packages = @q.result(distinct: true).order("id asc")
    end

    def create
      @package = current_store.store_packages.create(append_store_attrs package_params)
      respond_with @package, location: nil
    end

    def update
      @package.update(append_store_attrs package_params)
      respond_with @package, location: nil
    end

    def show
      set_search_params
      @q = @package.store_order_items.ransack(params[:q])
      @order_items = @q.result(distinct: true)
      respond_with @package, @order_items, location: nil
    end

    private
      def resource
        @package ||= set_package
      end

      def set_package
        @package = current_store.store_packages.find(params[:id])
      end

      def package_params
        params.require(:store_package).permit(:name, :code, :abstract, :remark)
      end

      def set_search_params
        params[:q] ||= {}
        begin
          params[:q][:created_at_gteq] = Time.zone.parse(params[:q][:created_at_gteq])
          params[:q][:created_at_lteq] = Time.zone.parse(params[:q][:created_at_lteq]).try(:end_of_day)
        rescue Exception => e
          params[:q][:created_at_gteq] = params[:q][:created_at_lteq] = nil
        end
      end
  end
end
