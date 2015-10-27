class StoreStaff <  ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :phone_number
  belongs_to :store
  belongs_to :store_chain


  validates :phone_number, presence: true
  validates :phone_number, length: {is: 11}, if: ->(staff){staff.phone_number.present?}
  validates :phone_number, numericality: { only_integer: true }, if: ->(staff){staff.phone_number.present?}

  validates :password, confirmation: true, unless: ->(staff){staff.password.blank?}

  # TODO Mysql set login_name not Null, add validation
  # Maybe login_name equal to phone_number?
  validates_presence_of :password, :password_confirmation, :login_name

  before_create :encrypt_password

  def self.encrypt_with_salt(txt, salt)
    Digest::SHA256.hexdigest("#{salt}#{txt}")
  end

  def reset_password(new_password, pass_confirmation)
    self.password = new_password
    self.password_confirmation = pass_confirmation
    encrypt_password
  end

  def reset_password!(new_password)
    self.reset_password(new_password)
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

  private
  def encrypt_password()
    self.salt = Digest::MD5.hexdigest("--#{Time.now.to_i}--")
    self.encrypted_password = self.class.encrypt_with_salt(self.password, self.salt)
  end
end

# == Schema Information
#
# Table name: store_staff
#
#  id                 :integer          not null, primary key
#  store_id           :integer
#  store_chain_id     :integer
#  login_name         :string(45)       not null
#  gender             :string(6)        default("male"), not null
#  first_name         :string(45)
#  last_name          :string(45)
#  name_display_type  :string(13)       default("lastname_pre"), not null
#  encrypted_password :text             not null
#  salt               :text             not null
#  work_status        :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  login_name_work_status_index  (login_name,work_status)
#
