class PasswordsController < ApplicationController
  layout 'plain'
  before_action :set_captcha, only: [:create, :edit]
  def new
    @captcha = params[:captcha] if params[:captcha]
  end

  def create
    if  @captcha.validate_with_token(params[:token])
      redirect_to edit_password_path(id: @captcha), notice: '恭喜你,验证通过!'
    else
      render :new
    end
  end

  def edit
    @store_staff = StoreStaff.where(login_name: @captcha.phone).last
  end

  def show

  end

  def send_validate_code
    if params[:phone].length != 11
      redirect_to new_passwords_path, notice: '请输入正确的手机号！'
    else
      @captcha = Captcha.new(token: generate_salt(6), sent: Time.now, phone: params[:phone])
      if @captcha.save
        SmsClient.publish(@captcha.phone, @captcha.token)
      else
        redirect_to new_passwords_path, notice: '发送失败！'
      end
    end
  end

  def update
    @store_staff = StoreStaff.find(set_store_staffer_params[:id])
    if @store_staff.reset_password!(set_store_staffer_params[:password], set_store_staffer_params[:password_confirmation] )
      redirect_to password_path, notice: '重置密码成功！'
    else
      redirect_to edit_password_path(id: params[:captcha_id]), notice: @store_staff.errors.first
    end
  end

  private
  def generate_salt(len)
    chars = Array(0..9)
    len.times.map { chars.sample }.join
  end

  def set_captcha
    @captcha = Captcha.find(params[:id])
  end

  def set_store_staffer_params
    params.require(:store_staff).permit(:password, :password_confirmation, :id)
  end
end
