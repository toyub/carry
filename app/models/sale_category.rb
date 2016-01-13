class SaleCategory < Category
  has_many :store_material_saleinfos
  has_many :order_items, through: :store_material_saleinfos, source: :store_order_items

end
