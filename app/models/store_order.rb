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
  scope :has_service, -> { where(service_included: true) }

  enum state: %i[pending queuing processing paying finished]
  enum task_status: %i[task_pending task_queuing task_processing task_checking task_checked task_finished]
  enum pay_status: %i[pay_pending pay_queuing pay_hanging pay_finished]

  before_create :set_numero

  before_save :set_amount

  accepts_nested_attributes_for :items

  validates_presence_of :items, :store_customer, :store_vehicle

  belongs_to :cashier, class_name: 'StoreStaff', foreign_key: 'cashier_id'

  def self.today
    where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end

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

  def paid?
    self.pay_hanging? || self.pay_finished?
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

  def creators
    { name: self.creator.full_name, id: self.creator.id }
  end

  def current_vehicle
    self.store_vehicle.license_number
  end

  def mechanic
    store_items
  end

  def store_items
    self.items.map{ |item| {name: item.creator.full_name, id: item.creator.id} }.uniq
  end

  def finish!
    self.task_finished! if workflows_finished?
    self.paid? ? self.finished! : self.paying!
  end

  def terminate!
    self.task_finished!
    self.paid? ? self.finished! : self.paying!
  end

  def terminate
    ActiveRecord::Base.transaction do
      self.terminate!
      self.workflows.map(&:terminate!)
    end
  end

  def workflows_finished?
    workflows.all? { |w| w.finished? }
  end

  def execute!
    return if !executeable?
    ActiveRecord::Base.transaction do
      construction_items.each do |item|
        service = item.orderable
        service.to_snapshot!(item)
      end
      if self.task_finished? || self.task_pending?
        self.task_queuing!
        self.queuing!
      end
    end
  end

  def situation
    read_attribute(:situation) || {}
  end

  def damages
    situation.fetch(:damages, [])
  end


  def repayment_remaining
    self.amount.to_f - self.filled.to_f
  end

  def payment_methods
    payments.map {|payment| payment.payment_method.cn_name }.join(',')
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
      self.amount = self.items.sum(:amount)
    end
end
