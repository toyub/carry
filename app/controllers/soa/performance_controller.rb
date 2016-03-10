class Soa::PerformanceController < Soa::BaseController
  def index
    @staffs = current_store.store_staff
    @departments = current_store.store_departments
    @positions = @departments[0].store_positions
    @month = Time.now
    @performances = ConstructPerformance.new(@staffs, @month)
  end

  def search
    @staffs = current_store.store_staff
                                              .by_keyword(params[:keyword])
                                              .by_level(params[:level_type_id])
                                              .by_job_type(params[:job_type_id])
                                              .by_department_id(params[:store_department_id])
    @departments = current_store.store_departments
    @positions = @departments.find(params[:store_department_id]).store_positions
    @month = (Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i) || Time.now
    @performances = ConstructPerformance.new(@staffs, @month)
    render :index
  end

  def show
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
  end
end
