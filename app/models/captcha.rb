class Captcha < ActiveRecord::Base
  validates :phone, presence: true, length: { is: 11 },
            format: { with: /(^\d+$)/, message: "请输入正确的手机号！" }
  validates :verification, presence: true, length: { is: 6 }

  scope :by_phone, ->(phone) { where(phone: phone) }
  scope :unused, -> { where(verification_used: false) }
  scope :unexpried, -> { where("sent_at > ?", EXPRIED.ago) }
  scope :valid_captchas, ->(phone) { by_phone(phone).unused.unexpried }

  before_create :encrypt_token

  EXPRIED = 15.minutes

  def self.generate!(phone, type_id)
    return false unless StoreStaff.phone_exist_or_available? phone
    create!(verification: generate_varification(6), switch_type_id: type_id, sent_at: Time.now, phone: phone)
  end

  def authenticate(token)
    self.token == token
  end

  def disabled_token!
    update!(token_available: false)
  end

  def store_staff
    StoreStaff.find_by(login_name: phone)
  end

  def validate_with_token(token_code)
    verification == token_code && !expried?
  end

  def expried?
    (Time.now - self.sent_at).to_i > EXPRIED
  end

  def send_message
    content =  "尊敬的用户：您正在重置密码，验证码：#{self.verification}，请在15分钟内按提示进行操作，切勿将验证码泄漏。"
    SmsClient.publish(phone, content)
  end

  private
  def self.generate_varification(len)
    chars = Array(0..9)
    len.times.map { chars.sample }.join
  end

  def encrypt_token
    self.token = SecureRandom.hex(32)
  end

end
