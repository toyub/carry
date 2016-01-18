module Sas
  class MonthConsumingCategories < Base

    private
    def set_data(orderitems)
      total_count = orderitems.count.to_f
      materials= orderitems.materials.count / total_count
      services= orderitems.services.count / total_count
      packages = orderitems.packages.count / total_count

      @data = [
        {value: materials, name: "商品销售" },
        {value: services, name:  "服务销售"},
        {value: packages, name:  "套餐销售"},
      ]
    end

  end
end
