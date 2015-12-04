class Captcha < ActiveRecord::Base
  validates :phone, presence: true, length: { is: 11 },
            format: { with: /(^\d+$)/, message: "请输入正确的手机号！" }
  validates :token, presence: true, length: { is: 6 }

  EXPRIED = 30.minutes

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
end
