class Crm::ExpenseRecordsController < Crm::BaseController

  before_action :set_customer, :enmu, :set_search_params, :set_vehicles

  def index
    @q = @customer.orders.ransack(params[:q])
    @orders = @q.result.order(id: 'desc').includes(:store_vehicle)
  end

  private

    def set_search_params
      params[:q] ||= {}
      get_search_params
      params[:q][:created_at_gteq] = Time.zone.parse(params[:q][:created_at_gteq]).beginning_of_day if params[:q][:created_at_gteq].present?
      params[:q][:created_at_lteq] = Time.zone.parse(params[:q][:created_at_lteq]).end_of_day if params[:q][:created_at_lteq].present?
    end

    def enmu
      @complaint_categories = Complaint::CATEGORY
      @complaint_ways = Complaint::WAY
    end

    def set_customer
      @customer = StoreCustomer.find(params[:store_customer_id])
    end

    def set_vehicles
      @vehicles = @customer.store_vehicles.map { |vehicle| [vehicle.license_number, vehicle.id] }
    end

    def get_search_params
      @vehicle_id = params[:q][:store_vehicle_id_eq]
      @beginning = params[:q][:created_at_gteq]
      @end = params[:q][:created_at_lteq]
    end

end
