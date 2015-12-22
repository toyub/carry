class StoreOrder < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle

  has_many :items, class_name: "StoreOrderItem"

  has_many :store_customer_payments

  enum state: %i[pending queueing processing paying paid finished]

  before_create :set_numero
  before_create :init_state
  before_save :update_amount

  accepts_nested_attributes_for :items

  def self.today
    where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end

  def cal_amount
    items.collect { |oi| oi.quantity * oi.price }.sum
  end

  def revenue_ables
    self.items.revenue_ables
  end

  def revenue_amount
    self.items.revenue_ables.collect { |oi| oi.quantity * oi.price }.sum
  end

  def deposits_cards
    self.items.packages.map{|item| item.orderable.package_setting.items.deposits_cards.to_a}.flatten
  end

  def taozhuangs
    orderables_ids = self.items.where(orderable_type: StoreMaterialSaleinfo.name).map{|saleinfo| saleinfo.orderable_id}
    orderables_ids.map { |id|  StoreMaterialSaleinfo.where(service_needed: true).where(id: id)}
  end

  private

    def set_numero
      today_order_count = store.store_orders.today.count + 1
      self.numero = Time.now.to_date.to_s(:number) + today_order_count.to_s.rjust(7, '0')
    end

    def update_amount
      self.amount = cal_amount
    end

    def init_state
      self.state = :pending
    end
end
