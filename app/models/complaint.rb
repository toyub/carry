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

  def detail
    read_attribute(:detail) || {}
  end

  def principal
    detail["principal"] || {}
  end

  def mechanic
    principal["mechanic"] || []
  end

  def saler
    principal["saler"]
  end

  def response
    detail["response"] || {}
  end

  def customer
    response["customer"]
  end

  def license_number
    self.store_vehicle.plates.last.license_number
  end

  def categoried
    detail['category'] || []
  end

  def way
    detail['way'] || []
  end

  def content
    detail['content']
  end

  def inquire
    detail['inquire']
  end

  def order_creator_name
    self.order.creator.full_name
  end

  def order_creator_id
    self.order.creator.id
  end

  def numero
    self.order.numero
  end

  def salers
    [select: saler, name: order_creator_name, id: order_creator_id]
  end

  def mechanics
    self.order.items.map{ |item| {name: item.creator.full_name, id: item.creator.id} }
  end

  def responses
    [customer: self.customer, principal: response["principal"]]
  end

  def created_at_format
    self.created_at.strftime("%Y-%m-%d")
  end

  def amounts
    self.order.items.inject(0){ |total, item| total+ item.amount  } if self.order
  end

  def order_creator
    StoreStaff.find(self.saler).full_name
  end
end
