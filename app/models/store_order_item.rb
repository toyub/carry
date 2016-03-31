class StoreOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :orderable, polymorphic: true
  belongs_to :package, polymorphic: true
  belongs_to :assetable, polymorphic: true
  belongs_to :store_order
  belongs_to :store_customer
  belongs_to :store_staff
  belongs_to :store_customer_asset_item
  has_one :store_service_snapshot
  has_many :store_service_workflow_snapshots
  has_many :store_staff_tasks

  before_save :set_amount
  before_create :set_store_info

  scope :materials, -> { where(orderable_type: "StoreMaterialSaleinfo") }
  scope :packages, -> { where(orderable_type: "StorePackage") }
  scope :services, -> { where(orderable_type: ["StoreService", 'StoreMaterialSaleinfoService']) }
  scope :revenue_ables, ->{where(orderable_type: [StoreService.name, StoreMaterialSaleinfo.name])}

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month..month.at_end_of_month) }
  scope :by_day, ->(date) { where(created_at: date.beginning_of_day..date.end_of_day) }
  scope :by_type, ->(type) { where(orderable_type: type) }
  scope :except_from_customer_assets, -> { where.not(from_customer_asset: true) }

  validates_presence_of :orderable
  validates :quantity, numericality: { only_integer: true, less_than_or_equal_to: 1000}
  validates :quantity, numericality: { only_integer: true, less_than_or_equal_to: 50, message: "错误: 套餐或商品组合下单时数量不能多于%{count}，请核对数量后再操作"}, if: :assetable_item?

  def gross_profit
    self.amount - self.total_cost
  end

  def type_cn_name
    orderable_type == "StoreMaterialSaleinfo" ? '商品' : '服务'
  end

  def cal_amount
    _amount()
  end

  def mechanics
    ['王晓勇', '李明亮']
  end

  def assetable_item?
    return true if self.orderable_type == StorePackage.name
    return true if self.orderable_type == StoreMaterialSaleinfo.name && self.orderable.service_needed
    false
  end

  def from_customer_asset?
    self.from_customer_asset
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

  def commission(beneficiary = 'person')
    store_staff.commission? ? orderable.commission(self, store_staff, beneficiary) : 0.0
  end

  def constructed_by? staff
    store_staff_tasks.exists?(mechanic_id: staff)
  end

  def saled_by? staff
    store_staff_id == staff.id
  end

  def has_commission?
    orderable.saleman_commission_template.present?
  end

  def self.total_amount
    sum(:amount)
  end

  def self.total_quantities
    sum(:quantity)
  end

  def retail_amount
    quantity.to_i * retail_price.to_f
  end

  def destroy_related_workflows
    ActiveRecord::Base.transaction do
      self.store_service_snapshot.destroy if self.store_service_snapshot.present?
      self.store_service_workflow_snapshots.map(&->(workflow){workflow.remove!})
      self.store_service_workflow_snapshots.delete_all
    end
  end

  def waste!
    self.store_service_snapshot.waste! if self.store_service_snapshot.present?
    self.update!(deleted: true)
  end

  private

    def set_amount
      self.amount = _amount()
    end

    def _amount
      quantity.to_i * price.to_f
    end

    def set_store_info
      self.store_id = store_order.store_id
      self.store_chain_id = store_order.store_chain.id
      self.store_staff_id = store_order.creator.id
    end

end
