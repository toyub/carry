class StoreOrder < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle

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
  scope :hanging, -> { where(hanging: true) }

  scope :need_temporary_purchase, -> { joins(:items).where('store_order_items.need_temporary_purchase is true').group("store_orders.id") }
  scope :task_finished_on, ->(date){where(task_finished_at: date.beginning_of_day..date.end_of_day)}
  scope :by_numero, ->(numero) { where("numero like ?", "%#{numero}%") if numero.present? }
  scope :need_temporary_purchase, -> { joins(:items).where('store_order_items.need_temporary_purchase is true').group("store_orders.id") }
  scope :created_before, ->(date = Time.now){where("created_at <= ?", date.end_of_day)}

  enum state: %i[pending queuing processing paying finished pausing]
  enum task_status: %i[task_pending task_queuing task_processing task_checking task_checked task_finished task_pausing]
  enum pay_status: %i[pay_pending pay_queuing pay_hanging pay_finished]
  enum waiting_area_id: %i[ waiting_in_queue waiting_in_workstation ]

  before_create :set_numero

  before_save :set_amount
  before_save :service_included_check

  accepts_nested_attributes_for :items

  validates_presence_of :items, :store_customer, :store_vehicle

  belongs_to :cashier, class_name: 'StoreStaff', foreign_key: 'cashier_id'

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

  def task_status_i18n
    I18n.t self.task_status, scope: [:enums, :store_order, :task_status]
  end

  def repayment_remaining
    self.amount.to_f - self.filled.to_f
  end

  def repay!(filled)
    self.update!(filled: self.filled.to_f + filled.to_f)
    if self.filled == self.amount
      self.pay_finished!
    end
  end

  def payment_methods
    payments.map {|payment| payment.payment_method_cn_name }.join(',')
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

  def complete!
    self.task_finished_at = Time.now
    self.paid? ? self.finished! : self.paying!
    self.task_finished!
  end

  def force_finish!
    discontinue!
    self.paid? ? self.finished! : self.paying!
  end

  def execution_job
    if self.service_included
      actualize
      try_to_execute
    else
      self.task_finished!
      self.paying!
    end
    self.pay_queuing!
    self
  end

  def discontinue!
    self.store_service_snapshots.unfinished.each(&->(service){ service.discontinue!})
    self.task_finished_at = Time.now
    self.task_finished!
    self.finished!
    #Send message tell the customer that his/her order is droped!
  end

  def waste!
    discontinue!
    self.items.each(&->(item){item.waste!})
    self.update!(deleted: true)
  end

  def continue_execute!(workstation)
    service = self.store_service_snapshots.not_deleted.in_executable_state.order_by_itemd.first
    if service.present?
      workflow = service.workflow_snapshots.not_deleted.in_executable_state.order_by_flow.first
      if workflow.present?
        workflow.find_a_workstaion_and_execute_otherwise_waiting_in(workstation)
      end
    end
  end

  def play!
    service = self.store_service_snapshots.not_deleted.in_executable_state.order_by_itemd.first
    if service.present?
      workflow = service.workflow_snapshots.not_deleted.in_executable_state.order_by_flow.first
      if workflow.present?
        if workflow.store_workstation.present?
          if workflow.executable?(workflow.store_workstation)
            workflow.execute(workflow.store_workstation)
          end
          return workflow
        else
          workflow.errors.add(:workstation, '请先指定施工的工位')
          return workflow
        end
      end
    end
    nil
  end

  def replay!
    if self.waiting_in_queue?
      self.queuing!
      self.task_queuing!
    else
      self.processing!
      self.task_processing!
    end
    self.store_service_snapshots.pausing.each do |service|
      service.replay!
    end
  end

  def pause_in_queuing_area!
    self.pausing!
    self.task_pausing!
    self.waiting_in_queue!
    self.store_service_snapshots.not_deleted.not_finished.each do |service|
      service.pause_in_queue!
    end
  end

  def pause_in_workstation!
    self.pausing!
    self.task_pausing!
    self.waiting_in_workstation!
    self.store_service_snapshots.not_deleted.not_finished.each do |service|
      service.pause_in_workstation!
    end
  end

  def current_workflow
    workflows.actively.first
  end

  private

  def try_to_execute
    if self.pending?
      self.queuing!
      self.task_queuing!
      execute_the_first_service
    elsif self.processing?
      workflow = current_workflow
      if workflow.blank?
        if self.workflows.not_deleted.count(:id) == self.workflows.not_deleted.finished.count(:id) #已经都结束了
          self.complete!
        else
          execute_the_first_service
        end
      else
        if workflow.dilemma?
          workflow.find_a_workstaion_and_execute
        end
      end
    elsif self.queuing?
      execute_the_first_service
    elsif self.pausing?
      if self.waiting_in_queue?
        self.store_service_snapshots.not_pausing.each(&->(service){service.pause_in_queue!})
      else
        self.store_service_snapshots.not_pausing.each(&->(service){service.pause_in_workstation!})
      end
    end
  end

  def actualize
    if actualization_demand_exists?
      self.update(service_included: true)
      actualization_demands.each do |item|
        service = item.orderable
        service.to_snapshot!(item)
      end
    end
  end

  def execute_the_first_service
    service = self.store_service_snapshots.not_deleted.pending.order_by_itemd.first
    if service.present?
      workflow = service.workflow_snapshots.not_deleted.pending.order_by_flow.first
      if workflow.present?
        workflow.find_a_workstaion_and_execute
      end
    end
  end

  def actualization_demands
    self.items.services.where.not(id: self.store_service_snapshots.pluck(:store_order_item_id))
  end

  def actualization_demand_exists?
    actualization_demands.exists?
  end

  def set_numero
    idx = store.store_orders.today.count + 1
    self.numero = Time.now.to_date.to_s(:number) + idx.to_s.rjust(7, '0')
  end

  def set_amount
    self.amount = self.items.map(&:cal_amount).sum
  end

  def service_included_check
    self.service_included = self.items.any?(&->(item){item.orderable_type == StoreService.name || item.orderable_type == StoreMaterialSaleinfoService.name })
    self
  end
end
