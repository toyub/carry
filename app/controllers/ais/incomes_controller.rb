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
      @service_categories = current_store.service_categories
      @material_categories = current_store.sale_categories
    elsif params[:type] == 'materials'
      @material_categories = current_store.sale_categories
    elsif params[:type] == 'services'
      @service_categories = current_store.service_categories
    end
    @first_category = @service_categories.try(:first) || @material_categories.try(:first)
  end
end
