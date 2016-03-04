class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_staff, :current_store

  include ApplicationHelper

  def current_user
    @current_user ||= StoreStaff.find_by(id: session[:user_id])
  end

  def current_store
    @current_store ||= current_user.store
    raise ActiveRecord::RecordNotFound.new unless @current_store
    @current_store
  end

  alias :current_staff :current_user

  def signed_in?
    current_user.present?
  end

  private

    def login_required
      redirect_to new_session_path unless current_user.present?
    end

    ## add store_attrs to params
    def append_store_attrs options
      nested_attrs = options.select(&nested_selector).transform_values(&nested_transformer)
      options.merge(store_options).merge(nested_attrs)
    end

    def store_options
      {store_staff_id: current_staff.id, store_id: current_store.id}
    end

    def nested_transformer
      -> (v) do
        case v
        when Array
          v.map { |x| x.merge(store_options) }
        when Hash
          v.values.first.is_a?(Hash) ? v.values.map { |x| x.merge(store_options) } : v.merge(store_options)
        end
      end
    end

    def nested_selector
      -> (k, v) { k.end_with?('_attributes') }
    end
end
