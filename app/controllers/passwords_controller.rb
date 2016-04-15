class PasswordsController < ApplicationController
  layout "login"
  before_action :set_captcha, only: :create
  def new
  end

  def create
    if @captcha && @captcha.verification == params[:verification]
      @captcha.update!(verification_used: true)
      redirect_to edit_password_path(phone: @captcha.phone, token: @captcha.token), notice: '恭喜你,验证通过!'
    else
      redirect_to new_password_path, notice: '请输入正确的验证码！'
    end
  end

  def edit
    captcha = Captcha.by_phone(params[:phone]).last
    if captcha && captcha.authenticate(params[:token])
      @store_staff = captcha.store_staff
      redirect_to new_password_path, notice: '请确认手机号是否注册！' if @store_staff.blank?
    end
  end

  def show

  end

  def send_validate_code
    @captcha = Captcha.generate!(params[:phone], SmsCaptchaSwitchType::TYPES_ID["密码找回验证"])
    if @captcha.present?
      @captcha.send_message
    else
      redirect_to new_password_path, notice: '发送失败！'
    end
  end

  def update
    captcha = Captcha.find_by(token: params[:captcha_token])
    @store_staff = captcha.store_staff if captcha && captcha.token_available
    if @store_staff && @store_staff.reset_password!(set_store_staffer_params[:password], set_store_staffer_params[:password_confirmation] )
      captcha.disabled_token!
      redirect_to password_path, notice: '重置密码成功！'
    else
      redirect_to edit_password_path(phone: captcha.phone, token: captcha.token), notice: @store_staff.errors.first
    end
  end

  private
  def set_captcha
    @captcha = Captcha.valid_captchas(params[:phone]).last if params[:phone].present?
  end

  def set_store_staffer_params
    params.require(:store_staff).permit(:password, :password_confirmation, :id)
  end
end
