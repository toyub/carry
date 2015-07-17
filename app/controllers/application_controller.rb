class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_staff

  def login_required
    if Rails.env.development?
      @current_user = StoreStaff.first
    end

    unless current_user.present?
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= session[:user_id].present? ? StoreStaff.where(id: session[:user_id]).first : nil
  end

  alias :current_staff :current_user

  def signed_in?
    current_user.present?
  end
end
