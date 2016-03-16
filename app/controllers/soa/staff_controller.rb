class Soa::StaffController < Soa::BaseController
  def index
    @staffs = current_store.store_staff.order('id asc')
                                       .by_keyword(params[:keyword])
                                       .by_level(params[:level_type_id])
                                       .by_job_type(params[:job_type_id])
  end

  def new
    @store = current_store
    @staff = @store.store_staff.new
    @employee = StoreEmployee.new
    @departments = current_store.store_departments
    @positions = @departments[0].try(:store_positions) || []
  end

  def create

    employee = StoreEmployee.new(employee_params)
    staff = StoreStaff.new(staff_params)

    staff.build_store_employee employee_params
    staff.store_id = current_staff.store_id
    staff.store_chain_id = current_staff.store_chain_id
    staff.login_name = staff.phone_number

    if staff.save && employee.save
      redirect_to new_soa_staff_setting_path(staff_id: staff.id)
    else
      render plain: staff.errors.messages
    end
  end

  def edit
    @staff = current_store.store_staff.find(params[:id])
    @departments = current_store.store_departments
    @positions = @staff.store_department.present? ? @staff.store_department.store_positions : (@departments[0].try(:store_positions) || [])
    @employee = @staff.store_employee || @staff.build_store_employee
  end

  def show
    @staff = current_store.store_staff.find(params[:id])
    @employee = @staff.store_employee || @staff.build_store_employee
  end

  def update
    staff = current_store.store_staff.find(params[:id])
    staff.update!(:mis_login_enabled, false) if params[:terminated_at].present?
    employee = staff.store_employee || staff.build_store_employee(employee_params)
    params[:staff][:login_name] = params[:employee][:phone_number] if params[:employee][:phone_number]
    staff.update!(staff_params)
    employee.update!(employee_params)
    redirect_to action: :show
  end

  private
  def staff_params
    params.require(:staff).permit(:login_name, :gender, :first_name, :last_name, :name_display_type,
                                                        :encrypted_password, :salt, :work_status, :job_type_id, :store_department_id,
                                                        :employeed_at, :terminated_at, :level_type_id, :reason_for_leave,
                                                        :numero, :store_position_id).merge(params.require(:employee).permit(:last_name, :first_name, :gender, :phone_number))
  end

  def employee_params
    params.require(:employee).permit(:last_name, :first_name, :gender, :birthday, :education,
                                                                  :polity, :native_place, :census_register, :identity_card,
                                                                  :marital_status, :height, :weight, :phone_number, :mailbox,
                                                                  :address, :census_register_address, :contact_one, :contact_one_phone_number,
                                                                  :contact_two, :contact_two_phone_number, :remark, :created_at, :updated_at)
  end
end
