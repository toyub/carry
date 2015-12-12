class Soa::SalariesController < Soa::BaseController
  def index
    @staffs = current_store.store_staff.by_keyword(params[:keyword])
  end

  def record
    @staffs = current_store.store_staff.salary_has_been_checked
    @departments = current_store.store_departments
    @positions = @departments[0].store_positions
  end

  def search
    @staffs = current_store.store_staff
                                              .by_keyword(params[:keyword])
                                              .by_level(params[:level_type_id])
                                              .by_job_type(params[:job_type_id])
    @departments = current_store.store_departments
    @positions = @departments.find(params[:store_department_id]).store_positions
    @search_date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
  end

  def check
    @staff = current_store.store_staff.find(params[:id])
    @prev_staff = @staff.prev
    @next_staff = @staff.next

    respond_to do |format|
      format.js
    end
  end

  def create
    @staff = current_store.store_staff.find(params[:staff_id])
    @salary = @staff.store_salaries.build(salary_param)
    @salary.status = true if params[:commit] == "核准"

    if @salary.save
      redirect_to record_soa_salaries_path, notice: "save successfully"
    else
      render plain: @salary.errors.messages
    end
  end

  private
  def salary_param
    params.require(:salary).permit(:amount_deduction, :amount_overtime, :amount_reward,
                                  :amount_bonus, :amount_insurence, :amount_cutfee, 
                                  :amount_should_cutfee, :status,
                                  :salary_should_pay, :salary_actual_pay,
                                  deduction: [:shigong, :shangpin, :shouka, :qita],
                                  bonus: [:gangwei, :zhusu, :canfei, :laobao, :gaowen],
                                  insurence: [:yibaofei, :baoxianjing],
                                  cutfee: [:weiji, :kaoqin, :jiedai, :qita, :gerendanbao])
  end

end
