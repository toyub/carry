module Xiaoshou
  class PackagesController < Xiaoshou::BaseController
    respond_to :html

    def index
      @data = to_builder
    end

    private
      def to_builder
        Jbuilder.encode do |json|
          json.materials current_store.store_materials, :id, :name, :price
          json.packages current_store.store_packages do |package|
            json.(package, :id, :name, :code, :abstract, :remark, :price)
            json.package_setting do
              json.id package.package_setting.id
              json.period package.package_setting.period
              json.period_unit package.package_setting.period_unit
              json.point package.package_setting.point
            end
          end
          json.commissions current_store.commission_templates, :id, :name
          json.services current_store.store_services, :id, :name, :retail_price
        end
      end
  end
end
