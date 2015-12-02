class CreateCaptchaService
  include Serviceable

  def initialize(captcha)
    @captcha = captcha
  end

  def call
    @captcha.transaction do
      @captcha.save!
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
