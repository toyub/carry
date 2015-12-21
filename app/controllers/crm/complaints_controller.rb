class Crm::ComplaintsController < Crm::BaseController
  before_action :set_customer, only: [:index, :edit, :update]
  before_action :set_complaint, only: [:edit, :update]
  skip_before_action :verify_authenticity_token, only: [:update]
  def index
    emu
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
  def emu
    @complaint_categories = Complaint::CATEGORY
    @complaint_ways = Complaint::WAY
  end

  def set_customer
    @customer = StoreCustomer.find(params[:store_customer_id])
  end

  def set_complaint
    @complaint = Complaint.find(params[:id])
  end

  def complaint_params
    params.require(:complaint).permit(
      :satisfaction,
      :updator_id,
      detail: [
        :content,
        :inquire,
        category: [],
        way: [],
        principal: [
          :saler,
          mechanic: []
        ],
        response: [
          :customer,
          :principal
        ]
      ]
    )
  end

end
