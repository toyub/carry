class Soa::RecordController < Soa::BaseController

  def index
    @staff = current_store.store_staff.find(params[:staff_id])
    if params[:type]
      @partial, @record = @staff.by_search_type(params[:type])
    else
      @partial = "salary_record"
      @record = @staff.store_salaries.all.order("id DESC")
    end
  end

  def search
    @staff = current_store.store_staff.find(params[:staff_id])
    @partial, @record = @staff.by_search_type(params[:type])
    respond_to do |format|
      format.js
    end
  end

end
