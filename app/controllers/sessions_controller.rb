class SessionsController < ApplicationController
  layout 'plain'

  def new
  end

  def create
    user = StoreStaff.where(login_name: "在职#{params[:login]}").first
    if user.blank? || user.encrypted_password != StoreStaff.encrypt_with_salt(params[:password], user.salt)
      flash[:error] = 'User login or password wrong!'
      redirect_to new_session_path
      return false
    end

    session[:user_id] = user.id
    redirect_to root_path ## should be user request url
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  def params_check
    if params[:login].blank? || params[:password].blank?
      flash[:error] = 'Can not be blank, login or password!'
      redirect_to new_session_path
      return false
    end
  end
end