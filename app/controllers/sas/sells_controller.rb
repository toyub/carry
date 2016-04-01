class Sas::SellsController < Sas::BaseController
  before_action :set_search_params, :search_params, only: :report

  def index
    @material_amount = current_store.store_material_saleinfos.amount_by_month
    @service_amount = current_store.store_services.amount_by_month
    @package_amount = current_store.store_packages.amount_by_month
    @top_saler = current_store.store_staff.best_saler
    @top_material = current_store.store_material_saleinfos.top_sales_by_month
    @top_service = current_store.store_services.top_sales_by_month
    @top_package = current_store.store_packages.top_sales_by_month
  end

  def report
  end

  private
  def search_params
    @order_items = current_store.store_order_items.ransack(params[:q]).result
    get_search_params
  end

  def set_search_params
    params[:q] ||= {}
    params[:q][:created_at_lteq].to_date.end_of_day if params[:q][:created_at_lteq].present?
  end

  def get_search_params
    @orderable_type = params[:q][:orderable_type_eq]
    @beginning = params[:q][:created_at_gteq]
    @end = params[:q][:created_at_lteq]
  end

end
