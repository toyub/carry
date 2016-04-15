class Crm::ComplaintsController < Crm::BaseController
  before_action :set_customer, only: [:index, :edit, :update]
  before_action :set_complaint, only: [:edit, :update]
  before_action :set_search_params, :enmu, :set_vehicles, only: [:index]
  skip_before_action :verify_authenticity_token, only: [:update]
  def index
    @q = @customer.complaints.ransack(params[:q])
    @complaints = @q.result.order(id: :desc).includes(:store_vehicle)
  end

  def edit
    respond_with @complaint, location: nil
  end


  def update
    if @complaint.update(complaint_params)
      redirect_to crm_store_customer_complaints_path(@customer), notice: '更新成功！'
    else
      render :index, notice: '更新失败!'
    end
  end

  private
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

  def set_complaint
    @complaint = Complaint.find(params[:id])
  end

  def set_search_params
    params[:q] ||= {}
    get_search_params
    params[:q][:created_at_lteq] = Time.zone.parse(params[:q][:created_at_lteq]).end_of_day if params[:q][:created_at_lteq].present?
  end

  def get_search_params
    @vehicle_id = params[:q][:store_vehicle_id_eq]
    @beginning = params[:q][:created_at_gteq]
    @end = params[:q][:created_at_lteq]
  end

  def complaint_params
    params.require(:complaint).permit(
      :satisfaction,
      :updator_id,
      detail: [
        :content,
        :inquire,
        categories: [],
        ways: [],
        principal: [
          :saler,
          mechanics: []
        ],
        response: [
          :customer,
          :principal
        ]
      ]
    )
  end

end
