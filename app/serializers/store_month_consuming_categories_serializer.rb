class StoreMonthConsumingCategoriesSerializer < ActiveModel::Serializer
  attr_accessor :data

  def initialize(month = Time.now)
    total_count = StoreOrderItem.by_month(month).count.to_f
    materials= StoreOrderItem.by_month(month).materials.count / total_count
    services= StoreOrderItem.by_month(month).services.count / total_count
    packages = StoreOrderItem.by_month(month).packages.count / total_count

    @data = [
      {value: materials, name: "商品销售" },
      {value: services, name:  "服务销售"},
      {value: packages, name:  "套餐销售"},
    ]
  end

end
