class Ais::IncomesController < Ais::BaseController
  before_action :get_categories, only: :index

  def index
  end

  private
  def get_categories
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end

    if params[:type].blank?
      @service_categories = ServiceCategory.all
      @material_categories = SaleCategory.all
    elsif params[:type] == 'materials'
      @material_categories = SaleCategory.all
    elsif params[:type] == 'services'
      @service_categories =  ServiceCategory.all
    end
    @first_category = @service_categories.try(:first) || @material_categories.try(:first)
    if @first_category.present?
      @order_items = @first_category.order_items.joins(:store_order).where(store_id: current_store.id).by_month(@date).order("id DESC")
    end
  end
end
