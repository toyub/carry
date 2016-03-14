module V1
  class VerifyCaptchaCode < Grape::API

    resource :verify_captcha_code do
      before do
        authenticate_platform!
      end

      add_desc '验证captcha'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :phone_number, type: String, desc: '手机号'
        requires :captcha, type: String, desc: '验证码'
      end

      get do
        cap = Captcha.valid_captchas(params[:phone_number]).last
        if cap && cap.verification == params[:captcha]
          cap.update!(verification_used: true)
          {success: true, notice: "验证通过", token: cap.token}
        else
          {success: false, notice: "验证失败，请重新输入"}
        end
      end
    end

  end
end
