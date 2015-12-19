class Soa::RecordController < Soa::BaseController

  def index
    @staff = current_store.store_staff.find(params[:id])
    @record = @staff.store_salaries.all.order("id DESC")
  end

  def search
    @staff = current_store.store_staff.find(params[:id])
    @partial, @record = @staff.by_search_type(params[:type])
    respond_to do |format|
      format.js
    end
  end

end
