module V1
  class SendCaptchaCode < Grape::API

    resource :send_captcha_code do
      before do
        authenticate_platform!
      end

      add_desc '密码找回'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :phone_number, type: String, desc: '手机号'
      end

      get do
        staff = StoreStaff.by_phone(params[:phone_number]).unterminated.last
        return {success: false, notice: "the staff is not exist or has terminated!"} if staff.blank?
        captcha = Captcha.generate!(params[:phone_number], SmsCaptchaSwitchType::TYPES_ID["密码找回验证"])
        options = {
          store_id: staff.store.id,
          receiver_type: StoreStaff.name,
          receiver_id: staff.id,
          first_category: SmsCaptchaSwitchType.name,
          second_category: SmsCaptchaSwitchType::TYPES_ID["密码找回验证"],
          content: "尊敬的用户：您正在重置密码，验证码：#{captcha.verification}，请在15分钟内按提示进行操作，切勿将验证码泄漏。 #{staff.store.name}"
        }
        SmsJob.perform_now(options)
      end
    end

  end
end
