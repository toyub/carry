class Soa::PerformanceController < Soa::BaseController
  def index
    @staffs = current_store.store_staff.where(regular: true).order("id ASC")
    @departments = current_store.store_departments
    @positions = @departments[0].try(:store_positions) || []
    @month = Time.now
    @staff_performances = ConstructPerformance.new(@staffs, @month).performances
  end

  def search
    @staffs = current_store.store_staff
                                              .by_keyword(params[:keyword])
                                              .by_level(params[:level_type_id])
                                              .by_job_type(params[:job_type_id])
                                              .by_department_id(params[:store_department_id])
    @departments = current_store.store_departments
    @positions = @departments.find_by_id(params[:store_department_id]).try(:store_positions) || []
    @month = (Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i) || Time.now
    @staff_performances = ConstructPerformance.new(@staffs, @month).performances
    render :index
  end

  def show
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
  end
end
