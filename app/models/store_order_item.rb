class StoreOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :orderable, polymorphic: true
  belongs_to :store_order
  belongs_to :store_customer
  belongs_to :store_staff
  has_one :store_service_snapshot
  has_many :store_service_workflow_snapshots


  before_save :cal_amount
  before_create :set_store_info

  scope :materials, -> { where(orderable_type: "StoreMaterialSaleinfo") }
  scope :packages, -> { where(orderable_type: "StorePackage") }
  scope :services, -> { where(orderable_type: "StoreService") }
  scope :revenue_ables, ->{where(orderable_type: [StoreService.name, StoreMaterialSaleinfo.name])}

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month..month.at_end_of_month) }
  scope :by_day, ->(date) { where(created_at: date.beginning_of_day..date.end_of_day) }
  scope :by_type, ->(type) { where(orderable_type: type) }

  validates_presence_of :orderable

  def cost_price
    23
  end

  def gross_profit
    self.amount - self.total_cost
  end

  def type_cn_name
    orderable_type == "StoreMaterialSaleinfo" ? '商品' : '服务'
  end

  def mechanics
    ['王晓勇', '李明亮']
  end

  def from_customer_asset?
    @s ||= rand(2)
    @s == 1
  end

  def workflow_mechanics
    self.store_service_snapshot.try(:workflow_snapshots).to_a
  end

  def to_cost_check_json
    {
     id: self.id,
     name: self.orderable.name,
     created_on: self.store_order.created_at.to_s(:date_with_short_time),
     standard_volume: self.standard_volume_per_bill,
     actual_volume: self.actual_volume_per_bill,
     numero: self.store_order.numero,
     mechanics: self.mechanics,
     cost_price_per_unit: self.cost_price,
     total_cost: self.total_cost
    }
  end

  def total_cost
    if self.divide_to_retail
      self.cost_price.to_f * self.actual_volume_per_bill.to_f
    else
      self.cost_price.to_f * self.quantity.to_f
    end
  end

  def category_name
    orderable.category.try(:name)
  end

  def barcode
    orderable.try(:barcode)
  end

  def speci
    orderable.try(:speci)
  end

  def commission
    store_staff.commission? ? orderable.commission(self) : 0.0
  end

  def self.total_amount
    sum(:amount)
  end

  def self.total_quantities
    sum(:quantity)
  end

  private

    def cal_amount
      self.amount = price * quantity
    end

    def set_store_info
      self.store_id = store_order.id
      self.store_chain_id = store_order.store_chain.id
      self.store_staff_id = store_order.creator.id
    end

end
