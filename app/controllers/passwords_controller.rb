class PasswordsController < ApplicationController
  layout 'plain'
  def new

  end

  def create

  end

  def edit

  end

  def show

  end

  def send_validate_code
    if params[:mobile].length != 11
      redirect_to new_passwords_path, notice: '请输入正确的手机号！'
    else
      SmsClient.publish(params[:mobile], generate_salt(6))
      render send_validate_code_passwords_path, notice: '发送成功,请注意查收！'
    end
  end

  private
  def generate_salt(len)
    chars = Array(0..9)
    len.times.map { chars.sample }.join
  end
end
