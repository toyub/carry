class Captcha < ActiveRecord::Base
  validates :phone, presence: true, length: { is: 11 },
            format: { with: /(^\d+$)/, message: "请输入正确的手机号！" }
  validates :token, presence: true, length: { is: 6 }

  scope :by_phone, ->(phone) { where(phone: phone) }
  scope :unused, -> { where(used: false) }
  scope :unexpried, -> { where("sent_at > ?", EXPRIED.ago) }
  scope :valid_captchas, ->(phone) { by_phone(phone).unused.unexpried }

  EXPRIED = 15.minutes

  def self.generate!(phone, type_id)
    create!(token: generate_token(6), switch_type_id: type_id, sent_at: Time.now, phone: phone)
  end

  def self.authenticate(phone, token)
    cap = valid_captchas(phone).last
    cap.present? && cap.token == token
  end

  def disabled_token!
    update!(used: true)
  end

  def store_staff
    StoreStaff.find_by(login_name: phone)
  end

  def validate_with_token(token_code)
     token == token_code && !expried?
  end

  def expried?
    (Time.now - self.sent_at).to_i > EXPRIED
  end

  def send_message
    SmsClient.publish(phone, token)
  end

  private
  def self.generate_token(len)
    chars = Array(0..9)
    len.times.map { chars.sample }.join
  end

end
