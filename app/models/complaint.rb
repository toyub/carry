class Complaint < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :store_customer
  belongs_to :store_vehicle
  belongs_to :order, class_name: 'StoreOrder', foreign_key: :store_order_id
  has_one :store_staff


  CATEGORY = {
              1 => '服务',
              2 => '质量',
              3 => '环境',
              4 => '其他'
            }

  WAY = {
          1 => '电话',
          2 => '现场',
          3 => '微信',
          4 => '短信'
        }

  def category(key)
    CATEGORY[key.to_i]
  end



end
