class Crm::StoreTrackingsController < Crm::BaseController
  before_action :set_customer

  def index
    params[:q] ||= {}
    q = StoreTracking.ransack(params[:q])
    @store_trackings = q.result(distinct: true)
    @tracking = StoreTracking.new
    @search = {
      plate: params[:q][:store_order_plate_id_eq],
      startDate: params[:q][:created_at_gt],
      endDate: params[:q][:created_at_lt],
      contact_way: params[:q][:contact_way_id_eq]
    }
  end

  def create
    tracking = StoreTracking.new tracking_params
    if tracking.save
      render json: {status: true, tracking: tracking}
    else
      render json: {status: false}
    end
  end

  def set_customer
    @customer = StoreCustomer.find(params[:store_customer_id])
  end

  private

    def tracking_params
      params.require(:store_tracking).permit(
          :creator_id,
          :title,
          :category_id,
          :contact_way_id,
          :executant_id,
          :content,
          :feedback,
          )
    end
end
