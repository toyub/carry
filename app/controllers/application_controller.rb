class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_staff, :current_store

  def current_user
    @current_user ||= StoreStaff.find_by(id: session[:user_id])
  end

  def current_store
    @current_store ||= current_user.store
  end

  alias :current_staff :current_user

  def signed_in?
    current_user.present?
  end

  private

    def login_required
      @current_user = StoreStaff.first if Rails.env.development?
      redirect_to new_session_path unless current_user.present?
    end
end
