class Soa::SalariesController < Soa::BaseController
  def index
    @staffs = current_store.store_staff.order("id asc").salary_has_been_not_confirmed.by_keyword(params[:keyword])
  end

  def record
    @staffs = current_store.store_staff.order("store_staff.id asc").salary_has_been_confirmed
    @departments = current_store.store_departments
    @positions = @departments[0].try(:store_positions) || []
    @salaries = current_store.store_salaries.where(created_month: Time.now.strftime("%Y%m"))
  end

  def search
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
    month = @date.strftime("%Y%m")
    @staffs = current_store.store_staff.order("id asc").salary_has_been_confirmed
                                       .by_keyword(params[:keyword])
                                       .by_created_month_in_salary(month)
                                       .by_department_id(params[:store_department_id])
                                       .by_position_id(params[:store_position_id])

    @departments = current_store.store_departments
    @positions = @departments[0].try(:store_positions) || []
    @salaries = current_store.store_salaries.where(created_month: month)
    render 'record'
  end

  def confirm
    @staff = current_store.store_staff.find(params[:id])
    @salary = StoreSalaryReview.new(@staff).salary

    respond_to do |format|
      format.js
    end
  end

  def check
    @staff = current_store.store_staff.find(params[:id])
    @salary = @staff.salary_of_month
    respond_to do |format|
      format.js
    end
  end

  def create
    @staff = current_store.store_staff.find(params[:staff_id])
    @salary = @staff.store_salaries.build(salary_param)
    if params[:commit] == "核准"
      @salary.status = true
      dest_url =  record_soa_salaries_path
    else
      dest_url =  soa_salaries_path
    end

    if @salary.save
      @salary.update(created_month: @salary.created_at.strftime("%Y%m"))
      redirect_to dest_url, notice: "save successfully"
    else
      render plain: @salary.errors.messages
    end
  end

  def update
    @staff = current_store.store_staff.find(params[:staff_id])
    @salary = @staff.store_salaries.find(params[:id])
    if params[:commit] == "核准"
      @salary.status = true
      dest_url =  record_soa_salaries_path
    else
      dest_url =  soa_salaries_path
    end

    if @salary.update(salary_param)
      redirect_to dest_url
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
