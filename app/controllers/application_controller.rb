class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_staff, :current_store

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

  def current_store
    @current_store ||= current_user.store
  end

  alias :current_staff :current_user

  def signed_in?
    current_user.present?
  end

  ## add store_attrs to params
  def append_store_attrs options
    nested_attrs = options.select(&nested_selector).transform_values(&nested_transformer)
    options.merge(store_options).merge(nested_attrs)
  end

  private

    def store_options
      {store_staff_id: current_staff.id, store_id: current_store.id}
    end

    def nested_transformer
      -> (v) { v.map { |x| x.merge(store_options) } }
    end

    def nested_selector
      -> (k, v) { k.end_with?('_attributes') }
    end
end
