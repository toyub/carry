class Crm::StoreTrackingsController < Crm::BaseController
  before_action :set_customer
  respond_to :js

  def index
    q = @customer.trackings.ransack(params[:q] ||= {})
    @store_trackings = q.result(distinct: true).order('id asc')
    @search = {
      plate: params[:q][:store_order_plate_id_eq],
      startDate: params[:q][:created_at_gt],
      endDate: params[:q][:created_at_lt],
      contact_way: params[:q][:contact_way_id_eq]
    }
    @tracking = StoreTracking.new
  end

  def create
    @tracking = StoreTracking.create tracking_params
    @tracking.update(trackable: @customer)
    respond_with @tracking, location: nil
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
        :feedback
      )
    end
end
