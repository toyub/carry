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

  def mechanics
    principal["mechanics"] || []
  end

  def saler_id
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
    detail['categories'] || []
  end

  def ways
    detail['ways'] || []
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

  def saler
    {selected: saler_id.to_i == order_creator_id, name: order_creator_name, id: order_creator_id}
  end

  def responses
    {customer: self.customer, principal: response["principal"]}
  end

  def response_principal
    response['principal']
  end

  def created_at_format
    self.created_at.strftime("%Y-%m-%d")
  end

  def order_creator
    StoreStaff.find(self.saler_id).full_name if self.saler_id
  end

  def constructors
    StoreStaff.where(id: mechanics)
  end
end
