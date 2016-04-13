class StoreServiceSnapshot < ActiveRecord::Base
  include BaseModel

  belongs_to :store_order_item
  has_many :store_service_store_materials
  has_many :store_materials, through: :store_service_store_materials
  belongs_to :unit, foreign_key: 'store_service_unit_id'
  has_many :workflow_snapshots, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :store_service_id
  belongs_to :store_order
  belongs_to :store_vehicle

  belongs_to :templateable, polymorphic: true

  validates :name, presence: true
  validates :retail_price, presence: true
  validates :store_staff_id, presence: true

  def waste!
    self.workflow_snapshots.each(&->(workflow){workflow.waste!})
    self.update!(deleted: true)
  end

  def sms_enabled?(remind_type)
    self.templateable.sms_enabled?(remind_type)
  end

  def message(remind_type)
    self.templateable.message(remind_type)
  end

  def remind_delay_interval(remind_type)
    self.templateable.remind_delay_interval(remind_type)
  end

end
