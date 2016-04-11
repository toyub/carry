class StoreMaterialOrder < ActiveRecord::Base
  include BaseModel
  before_create :set_numero

  belongs_to :store_material
  belongs_to :store_supplier
  belongs_to :withdrawaler, class_name: "StoreStaff", foreign_key: "withdrawal_by"

  belongs_to :store_material_inventory
  has_many :items, class_name: 'StoreMaterialOrderItem'
  has_many :store_materials, through: :items
  has_many :payments, class_name: 'StoreMaterialOrderPayment'


  accepts_nested_attributes_for :items, :payments

  scope :pending, ->{where('store_material_orders.process = 0')}
  scope :suspense, ->{where('0 <= store_material_orders.process and store_material_orders.process < 100')}
  scope :finished, ->{where('store_material_orders.process = 100')}
  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }

  def balance
    self.amount - self.paid_amount
  end

  def process_status_cn
    if process == 0
      '未入库'
    elsif process == 100
      '入库完成'
    else
      "#{process}入库"
    end
  end

  def withdrawaled?
    withdrawal_by.present?
  end

  def set_numero
    time_now = Time.now
    today_count = self.class.unscoped.where('created_at between ? and ?', time_now.beginning_of_day, time_now.end_of_day).count(:id) + 1
    self.numero = "OD#{time_now.strftime('%Y%m%d')}#{today_count.to_s.rjust(7, '0')}"
  end
end
