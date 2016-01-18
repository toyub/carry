module Sas
  class MonthConsumingCategories < Base

    private
    def set_data(store)
      orderitems = store.store_order_items.by_month
      total_count = orderitems.count.to_f

      unless total_count > 0
        materials= orderitems.materials.count / total_count
        services= orderitems.services.count / total_count
        packages = orderitems.packages.count / total_count
      end

      @data = [
        {value: materials, name: "商品销售" },
        {value: services, name:  "服务销售"},
        {value: packages, name:  "套餐销售"},
      ]
    end

  end
end
