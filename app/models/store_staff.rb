class StoreStaff <  ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :phone_number
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_department
  belongs_to :store_position
  has_many :store_protocol

  validates :password, confirmation: true, unless: ->(staff){staff.password.blank?}
  validates_presence_of :login_name

  before_create :encrypt_password

  def self.encrypt_with_salt(txt, salt)
    Digest::SHA256.hexdigest("#{salt}#{txt}")
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

  private
  def encrypt_password()
    self.salt = Digest::MD5.hexdigest("--#{Time.now.to_i}--")
    self.encrypted_password = self.class.encrypt_with_salt(self.password, self.salt)
  end
end
