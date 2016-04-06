class Sas::SellsController < Sas::BaseController
  before_action :calculate_data, only: :index
  before_action :search_params, only: :report
  before_action :set_search_params, :search_params, only: :report

  def index
  end

  def report
  end

  private
  def calculate_data
    @material_amount = current_store.material_sales_volume
    material_amount_last_month = current_store.material_sales_volume(1.month.ago)
    @material_growth_rate = material_amount_last_month > 0 ? ((@material_amount - material_amount_last_month) / material_amount_last_month) : 0.0

    @service_amount = current_store.service_sales_volume
    service_amount_last_month = current_store.service_sales_volume(1.month.ago)
    @service_growth_rate = service_amount_last_month > 0 ? ((@service_amount - service_amount_last_month) / service_amount_last_month) : 0.0

    @package_amount = current_store.package_sales_volume
    package_amount_last_month = current_store.package_sales_volume(1.month.ago)
    @package_growth_rate = package_amount_last_month > 0 ? ((@package_amount - package_amount_last_month) / package_amount_last_month) : 0.0

    @top_saler = current_store.store_staff.best_saler
    @top_material = current_store.store_material_saleinfos.top_sales_by_month
    @top_service = current_store.store_services.top_sales_by_month
    @top_package = current_store.store_packages.top_sales_by_month
  end

  def search_params
    @order_items = current_store.store_order_items.ransack(params[:q]).result
    get_search_params
  end

  def set_search_params
    params[:q] ||= {}
    set_default_search_params
    params[:q][:created_at_lteq].to_date.end_of_day if params[:q][:created_at_lteq].present?
  end

  def get_search_params
    @orderable_type = params[:q][:orderable_type_eq]
    @beginning = params[:q][:created_at_gteq]
    @end = params[:q][:created_at_lteq]
  end

  def set_default_search_params
    day = DateTime.now
    if params[:q][:created_at_gteq].blank? && params[:q][:created_at_gteq].blank?
      params[:q][:created_at_gteq] = day.at_beginning_of_month
      params[:q][:created_at_lteq] = day.at_end_of_month
    elsif params[:q][:created_at_gteq].blank?
      params[:q][:created_at_gteq] = day.at_beginning_of_month
    elsif params[:q][:created_at_lteq].blank?
      params[:q][:created_at_lteq] = day.at_end_of_month
    end
  end

end
