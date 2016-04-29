class StoreStaff <  ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_department
  belongs_to :store_position
  belongs_to :store_employee
  has_many :store_orders
  has_many :store_order_items
  has_many :creator_complaints, class_name: 'Complaint', as: :creator
  has_many :complaints
  has_many :store_protocols, dependent: :destroy
  has_many :store_events, dependent: :destroy
  has_many :store_contracts, class_name: "StoreQianDingHeTong", dependent: :destroy
  has_many :store_attendence, class_name: "StoreAttendence", dependent: :destroy
  has_many :store_rewards, class_name: "StoreReward", dependent: :destroy
  has_many :store_penalties, class_name: "StorePenalty", dependent: :destroy
  has_many :store_overworks, class_name: "StoreOvertime", dependent: :destroy
  has_many :store_salaries, dependent: :destroy
  has_one :api_token, dependent: :destroy, foreign_key: 'staff_id'
  has_one :store_group_member, foreign_key: 'member_id'
  has_one :store_group, through: :store_group_member
  has_many :store_staff_tasks, foreign_key: 'mechanic_id'
  has_many :sale_histories, class_name: 'StoreStaffSaleHistory'
  has_many :store_commission_items, as: :ownerable
  has_many :store_commissions, as: :ownerable

  validates_presence_of :phone_number
  validates_uniqueness_of :phone_number
  validates :password, confirmation: true, unless: ->(staff){staff.password.blank?}

  before_validation :set_full_name
  before_create     :encrypt_password
  before_create :set_default_password
  before_create :check_phone_number

  after_save :check_group_member

  scope :by_keyword, ->(keyword){ where('full_name like :name or phone_number like :phone_number',
                                                                                      name: keyword, phone_number: keyword)  if keyword.present?}
  scope :by_level, ->(level_type_id){ where(level_type_id: level_type_id) if level_type_id.present?}
  scope :by_job_type, ->(job_type_id){ where(job_type_id: job_type_id) if job_type_id.present?}
  scope :mis_login_enabled, ->{ where(mis_login_enabled: true).pluck(:full_name, :id) }
  scope :by_department_id, ->(store_department_id) { where(store_department_id: store_department_id) if store_department_id.present? }
  scope :by_position_id, ->(store_position_id) { where(store_position_id: store_position_id) if store_position_id.present? }
  scope :by_created_month_in_salary, ->(month) { joins(:store_salaries).where(store_salaries: {created_month: month} ) if month.present? }
  scope :by_phone, ->(phone) { where(phone_number: phone) }
  scope :unterminated, -> { where(demission: false) }

  scope :salary_has_been_confirmed, ->(month = Time.now.beginning_of_month.strftime("%Y%m")) { includes("store_salaries").where( store_salaries: { status: "true", created_month: month}) }
  scope :salary_has_been_not_confirmed, -> { where.not(id: salary_has_been_confirmed.pluck(:id)) }
  scope :mechanics, -> { where(job_type_id: JobType.find_by_name("技师").id ) }
  scope :verifiers, -> { where(mis_login_enabled: true) }
  scope :unregular, -> { where(regular: false) }
  scope :act_as_inspectors, ->{ where(job_type_id: [JobType.find_by_name("技师").id, JobType.find_by_name("销售").id])}

  ROLES = [
        {code: 0, name: '管理员'},
        {code: 1, name: '门店经理'},
        {code: 2, name: '收银员'},
        {code: 3, name: '出纳员'},
        {code: 4, name: '库管员'},
        {code: 5, name: '销售员'},
        {code: 6, name: '财务员'}
      ]

  def self.encrypt_with_salt(txt, salt)
    Digest::SHA256.hexdigest("#{salt}#{txt}")
  end

  def self.phone_exist_or_available?(phone)
    by_phone(phone).unterminated.last.present?
  end

  def job_type
    JobType.find(self.job_type_id.to_i)
  end

  def mechanic?
    self.job_type_id.to_i == JobType::TYPES_ID['技师']
  end

  def level_type
    StoreStaffLevel.find(self.level_type_id.to_i)
  end

  def includes_roles?(roles_codes=nil)
    if self.roles.blank? || roles_codes.blank?
      false
    else
      (self.roles & [roles_codes].flatten).length > 0
    end
  end

  def has_discount_authority?
    self.includes_roles?([0, 1])
  end

  def has_waste_order_authority?
    self.includes_roles?([0, 1])
  end

  def reset_password(new_password, password_confirmation)
    self.password = new_password
    self.password_confirmation = password_confirmation
    encrypt_password
  end

  def reset_password!(new_password, password_confirmation)
    self.reset_password(new_password, password_confirmation)
    self.save
  end

  def screen_name
    case self.name_display_type
    when 'firstname_pre'
      "#{self.first_name} #{self.last_name}"
    when 'lastname_pre'
      "#{self.last_name}#{self.first_name}"
    else
      "#{self.first_name} #{self.last_name}"
    end
  end

  def regular?
    regular || could_regular?
  end

  def has_regularized?
    store_protocols.where(type: "StoreZhuanZheng").present?
  end

  def regular_protocal
    store_protocols.where(type: "StoreZhuanZheng").last
  end

  def could_regular?
    return true if trial_period.blank?
    protocol = regular_protocal
    protocol.present? ? Time.now > protocol.effected_on : Time.now > trial_period.month.since(employed_date)
  end

  def current_month_regulared?
    protocol = regular_protocal
    if protocol.present? && (protocol.effected_on.strftime("%Y%m") == Time.now.strftime("%Y%m"))
      return true
    else
      return false
    end
  end

  def working_age
    ((((Time.now.year - employed_date.year) * 12) + (Time.now.month - employed_date.month)) / 12).ceil + 1
  end

  def terminated?
    terminated_at.present? && (Time.now > terminated_at)
  end

  def employed_date
    employeed_at || created_at
  end

  def insurence_enabled?
    bonus.present? && bonus['insurence_enabled'] == '1'
  end

  def current_salary
    regular? ? regular_salary.to_f : trial_salary.to_f
  end

  def reset_salary(new_salary)
    regular? ? update!(regular_salary: new_salary) : update!(trial_salary: new_salary)
  end

  def contract
    store_contracts.last
  end

  def contract_status
    contract.present? ? contract.effected_on.try(:strftime, "%Y-%m-%d") : "未签订合同"
  end

  def contract_life
    year = 12
    (contract.expired_on.try(:year).to_i - contract.effected_on.try(:year).to_i) * year + (contract.effected_on.try(:month).to_i - contract.expired_on.try(:month).to_i) if contract.present?
  end

  def contract_valid?
    contract.expired_on > contract.effected_on if contract && contract.expired_on.present? && contract.effected_on.present?
  end

  def amount_bonus
    self.bonus ||= {}
    bonus["gangwei"].to_f + bonus["canfei"].to_f + bonus["laobao"].to_f +
      bonus["gaowen"].to_f + bonus["zhusu"].to_f
  end

  def amount_insurence
    self.bonus ||= {}
    bonus["insurence_enabled"] == "1" ? bonus["yibaofei"].to_f + bonus["baoxianjing"].to_f : 0
  end

  def cutfee
    self.bonus ||= {}
    bonus["gerendanbao"].to_f + store_attendence.total + store_penalties.total
  end

  def should_pay
    sum = 0
    sum = current_salary + amount_bonus + amount_insurence + store_events.total_pay + commission_amount_total
    sum
  end

  def total_actual_salary
  end

  def salary_of_month(month = Time.now.beginning_of_month.strftime("%Y%m") )
    store_salaries.where(created_month: month, status: true).last
  end

  def by_search_type(type)
    record = ""
    partial = ""
    case type
    when "StoreReward", "StoreAttendence", "StorePenalty", "StoreOvertime"
        record = store_events.by_type(type)
        partial = "event_record"
    when "StoreSalary"
      record = store_salaries.all
      partial = "salary_record"
    when "StoreAdjustSalary"
      record = store_protocols.where(type: "StoreTiaoXin")
      partial = "adjust_salary_record"
    else
      record = "nothing could search!"
    end
    return partial, record
  end

  def mis_locked?
    !mis_login_enabled
  end

  def app_locked?
    !app_login_enabled
  end

  def erp_locked?
    !erp_login_enabled
  end

  def job_has_commission?
    [JobType::TYPES_ID['销售'], JobType::TYPES_ID['技师']].include? self.job_type_id
  end

  def commission?
    regular && deduct_enabled && job_has_commission?
  end

  def materials_amount_total(month = Time.now)
    store_order_items.by_month(month).map(&:amount).sum
  end

  def services_amount_total(month = Time.now)
    store_order_items.by_month(month).services.inject(0) {|sum, item| sum += item.amount }
  end

  def items_amount_total(month = Time.now)
    store_order_items.by_month(month).inject(0) {|sum, item| sum += item.amount }
  end

  def commission_amount_total(month = Time.now)
    commission? ? (sale_commission(month) + constucted_commission(month)) : 0.0
  end

  def constucted_commission(month = Time.now)
    (mechanic? && commission?) ? store_staff_tasks.by_month(month).map(&:commission).sum : 0.0
  end

  def sale_commission(month = Time.now)
    materials_commission(month) + services_commission(month) + packages_commission(month)
  end

  def materials_commission(month = Time.now)
    commission? ? store_order_items.by_month(month).materials.map(&:commission).sum : 0.0
  end

  def services_commission(month = Time.now)
    commission? ? store_order_items.by_month(month).where(orderable_type: StoreService.name).map(&:commission).sum : 0.0
  end

  def packages_commission(month = Time.now)
    commission? ? store_order_items.by_month(month).packages.map(&:commission).sum : 0.0
  end

  def commission_of(item)
    sum = 0.0
    sum = item.commission if item.saled_by? self
    sum += store_staff_tasks.by_item(item).map(&:commission).sum if item.constructed_by? self
    sum
  end

  def has_commission?(month = Time.now)
    if commission?
      if current_month_regulared?
        store_order_items.where("created_at > ?", regular_protocal.effected_on).any? { |item| item.orderable.saleman_commission_template.present? } || (mechanic? ? store_staff_tasks.where("created_at > ?", regular_protocal.effected_on).any? { |task| task.workflow_snapshot.mechanic_commission_template_id.present? } : false)
      else
        store_order_items.by_month(month).any? { |item| item.orderable.saleman_commission_template.present? } || (mechanic? ? store_staff_tasks.by_month(month).any? { |task| task.workflow_snapshot.mechanic_commission_template_id.present? } : false)
      end
    else
      false
    end
  end

  def sale_commission_of(item, beneficiary = 'person')
    commission? ? item.commission(beneficiary) : 0.0
  end

  def task_commission_of(task, beneficiary = 'person')
    commission? ? task.commission(beneficiary) : 0.0
  end

  def self.items_amount_total(month = Time.now)
    all.inject(0) {|sum, staff| sum += staff.items_amount_total(month) }
  end

  def self.commission_amount_total(month = Time.now)
    all.inject(0) {|sum, staff| sum += staff.commission_amount_total(month) }
  end

  def self.best_saler(month = Time.now)
    id = joins(:store_order_items)
          .where(store_order_items: {created_at: month.at_beginning_of_month .. month.at_end_of_month})
          .group(:store_staff_id).order("sum_amount desc").limit(1).sum(:amount).keys[0]

    find_by_id(id)
  end

  def sales_amount(month = Time.now)
    store_order_items.by_month(month).sum(:amount)
  end

  def sales_quantity(month = Time.now)
    store_orders.by_month(month).size
  end

  def photo
    "http://7xnnp5.com2.z0.glb.qiniucdn.com/FqDwPdqIc3p11utb-qEFURPRXJ8Z"
  end

  def full_name
    read_attribute(:full_name) || ""
  end

  private
  def encrypt_password()
    self.salt = Digest::MD5.hexdigest("--#{Time.now.to_f}--")
    self.encrypted_password = self.class.encrypt_with_salt(self.password, self.salt)
  end

  def set_full_name
      if self.changed_attributes.has_key?(:last_name) || self.changed_attributes.has_key?(:first_name)
          self.full_name = case self.name_display_type
          when 'firstname_pre'
            "#{self.first_name}#{self.last_name}"
          when 'lastname_pre'
            "#{self.last_name}#{self.first_name}"
          else
            "#{self.first_name}#{self.last_name}"
          end
      end
  end

  def set_default_password
    if self.password.blank?
      self.password = self.password_confirmation = rand
      encrypt_password
    end
  end

  def check_phone_number
    if StoreStaff.by_phone(self.phone_number).unterminated.present?
      errors.add(:notice, "您输入的号码正在使用，请使用新号码或停用该号码后再进行绑定。")
      false
    end
  end

  def check_group_member
    if self.mechanic?
      if self.store_group_member.present?
        self.store_group_member.set_level_type_id
      end
    else
      if self.store_group_member.present?
        self.store_group_member.set_deleted!
      end
    end
  end
end
