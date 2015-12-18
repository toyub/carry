class StoreStaff <  ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_department
  belongs_to :store_position
  belongs_to :store_employee
  has_many :store_protocols, dependent: :destroy
  has_many :store_events, dependent: :destroy
  has_many :store_salaries, dependent: :destroy

  validates_presence_of :phone_number
  validates :password, confirmation: true, unless: ->(staff){staff.password.blank?}

  before_validation :set_full_name
  before_create :set_default_password

  scope :by_keyword, ->(keyword){ where('full_name like :name or phone_number like :phone_number',
                                                                                      name: keyword, phone_number: keyword)  if keyword.present?}
  scope :by_level, ->(level_type_id){ where(level_type_id: level_type_id) if level_type_id.present?}
  scope :by_job_type, ->(job_type_id){ where(job_type_id: job_type_id) if job_type_id.present?}
  scope :by_department_id, ->(store_department_id) { where(store_department_id: store_department_id) if store_department_id.present? }
  scope :by_position_id, ->(store_position_id) { where(store_position_id: store_position_id) if store_position_id.present? }
  scope :by_created_month_in_salary, ->(month) { joins(:store_salaries).where(store_salaries: {created_month: month} ) if month.present? }

  scope :salary_has_been_confirmed, ->(month = Time.now.beginning_of_month.strftime("%Y%m")) { includes("store_salaries").where( store_salaries: { status: "true", created_month: month}) }
  scope :salary_has_been_not_confirmed, -> { where.not(id: salary_has_been_confirmed.pluck(:id)) }

  def self.encrypt_with_salt(txt, salt)
    Digest::SHA256.hexdigest("#{salt}#{txt}")
  end

  def job_type
    JobType.find(self.job_type_id)
  end

  def level_type
    StoreStaffLevel.find(self.level_type_id)
  end

  def reset_password(new_password, pass_confirmation)
    self.password = new_password
    self.password_confirmation = pass_confirmation
    encrypt_password
  end

  def reset_password!(new_password, pass_confirmation)
    self.reset_password(new_password, pass_confirmation)
    self.save
  end

  def screen_name
    case self.name_display_type
    when 'firstname_pre'
      "#{self.first_name} #{self.last_name}"
    when 'lastname_pre'
      "#{self.last_name} #{self.first_name}"
    else
      "#{self.first_name} #{self.last_name}"
    end
  end

  def trial_status
    status = "转正"
    remain_day = 0
    if store_protocols.operate_type("StoreZhuanZheng").size == 0
      remain_day = ( Date.today - (created_at - trial_period.months).to_date).round if trial_period
      status = remain_day < 0 ? "转正" : "试用中"
    else
      remain_day = ( Date.today - store_protocols.operate_type("StoreZhuanZheng")[0].effected_on ).round if trial_period
      status = remain_day > 0 ? "转正" : "试用中"
    end
    status
  end

  def insurence_enabled?
    return (bonus.try(:[], "insurence_enabled").nil? || bonus.try(:[], "insurence_enabled") == "0") ? "否" : "是"
  end

  def current_salary
    trial_status == "转正" ? regular_salary.to_f : trial_salary.to_f
  end

  def contract_period
    month = 30
    protocol = store_protocols.operate_type("StoreQianDingHeTong")[0]
    ((protocol.expired_on - protocol.effected_on) / month).round if protocol
  end

  def contract_status
    "未签约"
    contract_period < 0 ? "到期" : "有效" if contract_period
  end

  def bonus_amount
    bonus["gangwei"].to_f + bonus["canfei"].to_f + bonus["laobao"].to_f +
      bonus["gaowen"].to_f + bonus["zhusu"].to_f
  end

  def insurence_amount
   bonus["insurence_enabled"] == "1" ? bonus["yibaofei"].to_f + bonus["baoxianjing"].to_f : 0
  end

  def cutfee
    bonus["gerendanbao"].to_f + store_events.total_pay_of_type_per_month("StoreAttendence").to_f + store_events.total_pay_of_type_per_month("StorePenalty").to_f
  end

  def should_pay
    sum = 0
    sum = current_salary + bonus_amount + insurence_amount + store_events.total_pay
    sum
  end

  def get_this_month_salary
    salary = store_salaries.without_confirm_salary_of_this_month.first
    salary = store_salaries.build(set_default_salary_params) if salary.nil?
    salary
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

  def locked?
    !mis_login_enabled
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

  def set_default_salary_params
    {
      amount_deduction: 5,
      deduction: {},
      amount_overtime: self.store_events.total_pay_of_type_per_month('StoreOvertime'),
      amount_reward: self.store_events.total_pay_of_type_per_month('StoreReward'),
      bonus: {gangwei: bonus["gangwei"], zhusu: bonus["zhusu"], canfei: bonus["canfei"], laobao: bonus["laobao"], gaowen: bonus["gaowen"] },
      amount_bonus: self.bonus_amount,
      insurence: {yibaofei: bonus["yibaofei"], baoxianjing: bonus["baoxianjing"]},
      amount_insurence: self.insurence_amount,
      cutfee: {weiji: store_events.total_pay_of_type_per_month("StorePenalty"),
               kaoqin: store_events.total_pay_of_type_per_month("StoreAttendence"),
               jiedai: "",
               qita: "",
               gerendanbao: bonus["gerendanbao"] },
      amount_should_cutfee: cutfee,
      amount_cutfee: cutfee,
      salary_should_pay: should_pay,
      salary_actual_pay: should_pay - cutfee
    }
  end
end
