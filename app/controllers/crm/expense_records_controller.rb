class Crm::ExpenseRecordsController < Crm::BaseController

  before_action :set_customer, :enmu, :set_search_params, :set_vehicles

  def index
    @q = @customer.orders.available.ransack(params[:q])
    @orders = @q.result.order(id: 'desc').includes(:store_vehicle)
  end

  private

    def set_search_params
      params[:q] ||= {}
      begin
        created_at_gteq = Time.zone.parse(params[:q][:created_at_gteq])
        created_at_lteq = Time.zone.parse(params[:q][:created_at_lteq]).try(:end_of_day)
      rescue Exception => e
        created_at_gteq = created_at_lteq = nil
      end
      get_search_params
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
