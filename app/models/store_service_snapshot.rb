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

  enum status: %i[ pending processing finished pausing ]
  enum waiting_area_id: %i[ waiting_in_queue waiting_in_workstation ]

  scope :not_deleted, ->{where(deleted: false)}

  scope :not_finished, ->{where.not(status: StoreServiceSnapshot.statuses[:finished])}
  scope :order_by_itemd, ->{order('store_order_item_id asc')}
  scope :not_pausing, ->{where.not(status: StoreServiceSnapshot.statuses[:pausing])}
  scope :unfinished, ->{where.not(status: StoreServiceSnapshot.statuses[:finished])}

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

  def replay!
    if self.waiting_in_queue?
      self.pending!
    else
      self.processing!
    end
    self.workflow_snapshots.pausing.each do |workflow|
      workflow.replay!
    end
  end

  def complete!
    self.finished!
    if self.store_order.store_service_snapshots.pending.present?
      self.store_order.continue_execute!(self.workflow_snapshots.finished.order('finished_at desc').first.store_workstation)
    else
      self.store_order.complete!
    end
  end

  def discontinue!
    self.finished!
    self.workflow_snapshots.not_deleted.unfinished.each(&->(workflow){ workflow.discontinue!})
  end

  def pause_in_workstation!
    self.pausing!
    self.waiting_in_workstation!
    self.workflow_snapshots.not_deleted.processing.each do |workflow|
      workflow.pause_in_workstation!
    end
  end

  def pause_in_queue!
    self.pausing!
    self.waiting_in_queue!
    self.workflow_snapshots.not_deleted.processing.each do |workflow|
      workflow.pause_in_queue!
    end
  end
end
