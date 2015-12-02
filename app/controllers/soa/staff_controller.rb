class Soa::StaffController < Soa::ControllerBase
  def index
    @store = current_store
    @staffs = @store.store_staff
  end

  def new
    @store = current_store
    @staff = @store.store_staff.new
    @departments = current_store.store_departments
    @positions = @departments[0].store_positions
  end

  def create

    employee = StoreEmployee.new(employee_params)
    staff = StoreStaff.new(staff_params)
    staff.store_id = current_staff.store_id
    staff.store_chain_id = current_staff.store_chain_id
    staff.login_name = staff.phone_number
    staff.password = staff.password_confirmation = '123456'
    if employee.save && staff.save
      redirect_to new_soa_setting_path(id: staff.id)
    else
      render json: {
        staff_errors: staff.errors,
        employee_errors: employee.errors
      }
    end
  end

  def edit
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @departments = current_store.store_departments
    @positions = @departments[0].store_positions
  end

  def update
    render json: params
  end

  private
  def staff_params
    params.require(:staff).permit(:login_name, :gender, :first_name, :last_name, :name_display_type,
                                                        :encrypted_password, :salt, :work_status, :job_type_id, :store_department_id,
                                                        :employeed_at, :terminated_at, :levle_type_id, :reason_for_leave,
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
