class StoreStaff <  ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_department
  belongs_to :store_position
  belongs_to :store_employee
  has_many :store_protocols, dependent: :destroy
  has_many :store_events, dependent: :destroy

  validates_presence_of :phone_number
  validates :password, confirmation: true, unless: ->(staff){staff.password.blank?}

  before_validation :set_full_name
  before_create :set_default_password

  scope :by_keyword, ->(keyword){ where('full_name like :name or phone_number like :phone_number',
                                                                                      name: keyword, phone_number: keyword)  if keyword.present?}
  scope :by_level, ->(level_type_id){ where(level_type_id: level_type_id) if level_type_id.present?}
  scope :by_job_type, ->(job_type_id){ where(job_type_id: job_type_id) if job_type_id.present?}


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
    if store_protocols.operate_type("StoreZhuanZheng").size == 0
      remain_day = ( Date.today - (created_at - trial_period.months).to_date).round if trial_period
      status = remain_day < 0 ? "转正" : "试用中"
    else
      remain_day = ( Date.today - store_protocols.operate_type("StoreZhuanZheng")[0].effected_on ).round if trial_period
      status = remain_day > 0 ? "转正" : "试用中"
    end
    status
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

  def locked?
    !mis_login_enabled
  end

  private
  def encrypt_password()
    self.salt = Digest::MD5.hexdigest("--#{Time.now.to_i}--")
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
end
