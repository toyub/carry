class ServiceCategory < Category
  has_many :store_services, foreign_key: 'store_service_category_id'
  has_many :order_items, through: :store_services, source: :store_order_items

end
