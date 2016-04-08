class StoreOrder < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle
  belongs_to :plate, class_name: 'StoreVehicleRegistrationPlate', foreign_key: 'store_vehicle_registration_plate_id'

  has_one :store_tracking
  has_many :items, class_name: 'StoreOrderItem'
  has_many :complaints
  has_many :store_customer_payments
  has_many :store_service_snapshots
  has_many :workflows, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :store_order_id
  has_many :payments, class_name: 'StoreCustomerPayment'

  has_many :store_order_repayments
  has_many :store_repayments, through: :store_order_repayments

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }
  scope :by_day, ->(date = Date.today) { where(created_at: date.beginning_of_day..date.end_of_day) }
  scope :today, -> { by_day(Date.today) }
  scope :has_service, -> { where(service_included: true) }
  scope :unfinished, -> { where.not(state: StoreOrder.states[:finished]) }
  scope :unpending, -> { where.not(state: StoreOrder.states[:pending]) }

  scope :waiting, -> {where(task_status: [StoreOrder.task_statuses[:task_queuing], StoreOrder.task_statuses[:task_pausing]])}

  scope :unpaid, ->{where(pay_status: StoreOrder.pay_statuses[:pay_queuing])}
  scope :paid, ->{where(pay_status: [ StoreOrder.pay_statuses[:pay_hanging], StoreOrder.pay_statuses[:pay_finished] ])}
  scope :paid_on, ->(date){where(paid_at: date.beginning_of_day..date.end_of_day)}

  scope :available, -> {where(deleted: false)}

  enum state: %i[pending queuing processing paying finished pausing]
  enum task_status: %i[task_pending task_queuing task_processing task_checking task_checked task_finished task_pausing]
  enum pay_status: %i[pay_pending pay_queuing pay_hanging pay_finished]

  before_create :set_numero

  before_save :set_amount

  accepts_nested_attributes_for :items

  validates_presence_of :items, :store_customer, :store_vehicle

  belongs_to :cashier, class_name: 'StoreStaff', foreign_key: 'cashier_id'

  def self.counts_by_state(date_time = Time.now)
    counts = self.where('created_at BETWEEN ? AND ?', date_time.beginning_of_day, date_time.end_of_day)
                 .group(:state).count(:id)
    {
      pending: counts[StoreOrder.states[:pending]].to_i,
      queuing: counts[StoreOrder.states[:queuing]].to_i,
      processing: counts[StoreOrder.states[:processing]].to_i,
      paying: counts[StoreOrder.states[:paying]].to_i,
      finished: counts[StoreOrder.states[:finished]].to_i
    }
  end

  def state_i18n
    I18n.t self.state, scope: [:enums, :store_order, :state]
  end

  def pay_status_i18n
    if self.paid?
      '已付款'
    else
      '未付款'
    end
  end

  def task_status_i18n
    I18n.t self.task_status, scope: [:enums, :store_order, :task_status]
  end

  def paid?
    self.pay_hanging? || self.pay_finished?
  end

  def hanging!
    self.update! hanging: true
    self.pay_hanging!
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

  def packages
    self.items.packages
  end

  def taozhuangs
    items.where(orderable_type: StoreMaterialSaleinfo.name).select{|order_item| order_item.orderable.service_needed}
  end

  def license_number
    self.store_vehicle.license_number
  end

  def finish!
    terminate! if workflows_finished?
  end

  def terminate!
    self.task_finished!
    self.paid? ? self.finished! : self.paying!
  end

  def terminate
    ActiveRecord::Base.transaction do
      self.terminate!
      self.workflows.unfinished.map(&:terminate!)
      self.workflows.last.send_sms
    end
  end

  def settle_down
    if self.paying?
      self.state = :finished
    end
  end

  def settle_down!
    if self.paying?
      self.finished!
    end
  end

  def workflows_finished?
    workflows.all? { |w| w.finished? }
  end

  def execute!
    return self.paying! if !executeable?
    self.update(service_included: true)
    ActiveRecord::Base.transaction do
      construction_items.each do |item|
        service = item.orderable
        service.to_snapshot!(item)
      end
      if self.task_finished? || self.task_pending?
        self.task_queuing!
        self.queuing!
        SpotDispatchJob.perform_now(self.store_id)
      end
    end
  end

  def situation
    read_attribute(:situation) || {}
  end

  def damages
    situation.fetch(:damages, [])
  end

  def human_readable_status
    if self.pending?
      '草稿'
    elsif self.finished?
      '完结'
    elsif self.paying?
      '完工(待付款)'
    else
      "#{self.state_i18n}(#{self.pay_status_i18n})"
    end
  end

  def task_status_i18n
    I18n.t self.task_status, scope: [:enums, :store_order, :task_status]
  end

  def repayment_remaining
    self.amount.to_f - self.filled.to_f
  end

  def payment_methods
    payments.map {|payment| payment.payment_method_cn_name }.join(',')
  end

  def execution_job
    OrderExecutionJob.perform_now(id)
  end

  def repay!(filled)
    self.update!(filled: self.filled.to_f + filled.to_f)
    if self.filled == self.amount
      self.pay_finished!
    end
  end

  def assign_mechanics
    self.workflows.pending.order("created_at asc").map(&:assign_mechanics)
    self.workflows.pending.order("created_at asc").map(&:set_mechanic_busy)
  end

  def waste!
    self.items.each(&->(item){item.waste!})
    self.update!(deleted: true)
  end

  def pause!

  end

  def play!(from = 'processing')
    workflow = self.workflows.processing.first || self.workflows.pending.first
    if from == 'queuing'
      self.queuing!
      self.task_queuing!
    else
      self.processing!
      self.task_processing!
      workflow.play!
    end
  end

  def pause_in_queuing_area!
    workflow = self.workflows.processing.first || self.workflows.pending.first
    workflow.pause_in_queuing_area! if self.task_processing?
    self.pausing!
    self.task_pausing!
  end

  def pause_in_workstation!
    workflow = self.workflows.processing.first || self.workflows.pending.first
    workflow.pause_in_workstation!
    self.pausing!
    self.task_pausing!
  end

  def self.waiting_in_queuing_area
    self.waiting.reject { |o| o.task_pausing? && o.waiting_in_workstation? }
  end

  def waiting_in_workstation?
    workflow = self.workflows.processing.first || self.workflows.pending.first
    workflow.waiting_in_workstation?
  end

  private
    def construction_items
      self.items.services.where.not(id: self.store_service_snapshots.pluck(:store_order_item_id))
    end

    def executeable?
      construction_items.present?
    end

    def set_numero
      idx = store.store_orders.today.count + 1
      self.numero = Time.now.to_date.to_s(:number) + idx.to_s.rjust(7, '0')
    end

    def set_amount
      self.amount = self.items.map(&:cal_amount).sum
    end
end
