module Api
  class ComplaintsController < BaseController
    skip_before_action :verify_authenticity_token, only: [:create]
    before_action :set_store_order, only: [:new]
    def new
      respond_with @store_order, location: nil
    end

    def create
      complaint = current_staff.creator_complaints.new(complaint_params)
      if complaint.save
        redirect_to crm_store_customer_expense_records_path(complaint.store_customer), notice: '投诉成功！'
      else
        render :new, notice: '失败了！'
      end
    end

    private
    def complaint_params
      params.require(:complaint).permit(
        :store_customer_id,
        :store_vehicle_id,
        :satisfaction,
        :store_order_id,
        :creator_id,
        :creator_type,
        :updator_id,
        :store_chain_id,
        :store_id,
        detail: [
                  :content,
                  :inquire,
                  {:categories => [], :ways => []},
                  principal: [:saler, {:mechanics => []}],
                  response:  [:principal, :customer]
                ])
    end

    def set_store_order
      @store_order = StoreOrder.find(params[:store_order_id])
    end

  end
end
