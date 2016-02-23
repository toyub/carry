module V1
  class Varificate < Grape::API

    resource :varificate do
      before do
        authenticate_platform!
        authenticate_sn_code!
      end

      add_desc '验证captcha'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :phone_number, type: String, desc: '手机号'
        requires :captcha, type: String, desc: '验证码'
      end

      get do
        cap = Captcha.find_by(phone: params[:phone_number])
        if cap.validate_with_token(params[:captcha])
          {status: 'success', notice: "验证通过"}
        else
          {status: 'fails', notice: "验证失败，请重新输入"}
        end
      end
    end

  end
end
