module Sas
  class MonthConsumingCategories < Base

    private
    def set_data(store)
      total_count = store.sales_volume.to_f

      if total_count > 0
        materials= store.material_sales_volume / total_count
        services= store.service_sales_volume / total_count
        packages = store.package_sales_volume / total_count
      end

      @data = [
        {value: materials, name: "商品销售" },
        {value: services, name:  "服务销售"},
        {value: packages, name:  "套餐销售"},
      ]
    end

  end
end
