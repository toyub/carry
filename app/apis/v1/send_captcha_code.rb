module V1
  class SendCaptchaCode < Grape::API

    resource :send_captcha_code do
      before do
        authenticate_platform!
        authenticate_sn_code!
      end

      add_desc '密码找回'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :phone_number, type: String, desc: '手机号'
      end

      get do
        staff = StoreStaff.find_by(phone_number: params[:phone_number])
        return {status: "fails", notice: "the staff is not exist or has terminated!"} if staff.blank? || staff.terminated?
        captcha = Captcha.generate!(params[:phone_number])
        options = {
          store_id: staff.store.id,
          receiver_type: "StoreStaff",
          receiver_id: staff.id,
          first_category: 'SmsCaptchaSwitchType',
          second_category: SmsCaptchaSwitchType::TYPES_ID["密码找回验证"],
          content: "尊敬的用户：您正在重置密码，验证码：#{captcha.token}，请在15分钟内按提示进行操作，切勿将验证码泄漏。 #{staff.store.name}"
        }
        SmsJob.perform_now(options)
      end
    end

  end
end
