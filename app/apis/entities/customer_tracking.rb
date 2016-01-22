module Entities
  class CustomerTracking < Grape::Entity
    expose :contact_way
    expose :content
    expose :category_name
    expose :created_at do |tracking, options|
      tracking.created_at.strftime('%Y-%m-%d')
    end
    expose :numero do |tracking, options|
      tracking.store_order.try(:numero) || '无关联信息'
    end
    expose :executant do |tracking, options|
      tracking.automatic ? '系统' : tracking.executant
    end
  end
end
