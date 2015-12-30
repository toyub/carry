class StoreOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :orderable, polymorphic: true
  belongs_to :store_order
  belongs_to :store_customer
  has_one :store_service_snapshot
  has_many :store_service_workflow_snapshots


  before_save :cal_amount
  before_create :set_store_info

  scope :materials, -> { where(orderable_type: "StoreMaterialSaleinfo") }
  scope :packages, -> { where(orderable_type: "StorePackage") }
  scope :services, -> { where(orderable_type: "StoreService") }
  scope :revenue_ables, ->{where(orderable_type: [StoreService.name, StoreMaterialSaleinfo.name])}

  validates_presence_of :orderable

  def cost_price
    23
  end

  def retail_price
    50
  end

  def gross_profit
    self.quantity * (self.price - self.cost_price)
  end

  def workflow_mechanics
    self.store_service_snapshot.workflow_snapshots
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
