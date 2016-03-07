class SessionsController < ApplicationController
  layout "login"
  before_action :set_staff, only: [:create]

  def new
  end

  def create
    @status = AuthenticateStaffService.call(@staff, params[:password])
    if @status.success?
      session[:user_id] = @staff.id
      redirect_to root_path
    else
      redirect_to new_session_path, notice: @status.notice
    end
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

  def edit

  end

  private
    def set_staff
      @staff = StoreStaff.find_by(login_name: params[:login])
    end
end
