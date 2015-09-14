class StoreStaff <  ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  belongs_to :store
  belongs_to :store_chain
  

  #validates :phone_number, presence: true
  #validates :phone_number, length: {is: 11}, if: ->(staff){staff.phone_number.present?}
  #validates :phone_number, numericality: { only_integer: true }, if: ->(staff){staff.phone_number.present?}
  #validates uniqueness

  validates :password, presence: true
  validates :password, confirmation: true, unless: ->(staff){staff.password.blank?}

  validates :password_confirmation, presence: true

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
