class Captcha < ActiveRecord::Base
  validates :phone, presence: true, length: { is: 11 }
  validates :token, presence: true, length: { is: 6 }

  EXPRIED = 30.minutes

  def staff
    StoreStaff.find_by(login_name: phone)
  end

  def validate_with_token(token_code)
     token == token_code && ！expried?
  end

  def expried?
    Time.now - self.sent_at > EXPRIED
  end
end
