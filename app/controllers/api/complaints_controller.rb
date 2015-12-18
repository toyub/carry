module Api
  class ComplaintsController < BaseController
    skip_before_action :verify_authenticity_token, only: [:create]
    def new
      @store_order = StoreOrder.find(params[:store_order_id])
      vehicle = @store_order.store_vehicle.plates.last.license_number
      numero = @store_order.numero
      creator = [name: @store_order.creator.full_name, id: @store_order.creator.id]
      mechanic = @store_order.items.map{ |item| {name: item.creator.full_name, id: item.creator.id} }
      vehicle_id = @store_order.store_vehicle.id
      render json: {vehicle: vehicle, numero: numero, creator: creator,
                    mechanic: mechanic, vehicle_id: vehicle_id}
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
        detail: [
                  :content,
                  :inquire,
                  {:category => [], :way => []},
                  principal: [:saler, {:mechanic => []}],
                  response:  [:principal, :customer]
                ])
    end

  end
end
