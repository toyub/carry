class Soa::StaffController < Soa::ControllerBase
  def index
    @store = current_store
    @staffs = @store.store_staff
  end

  def new
    @store = current_store
    @staff = @store.store_staff.new
  end

  def create
    @store = current_store
    x = @store.store_staff.where(login_name: staff_params[:phone_number]).count
    if x > 0
      render text: 'Error login name dup!'
      return false
    end

    x = @store.store_staff.where(last_name: staff_params[:last_name], first_name: staff_params[:first_name]).count
    if x > 0
      render text: 'Warning same name ><'
      return false
    end
    staff = @store.store_staff.new(staff_params)
    staff.store_chain_id = @store.store_chain_id
    staff.login_name = staff.phone_number
    staff.password = staff.password_confirmation = staff.phone_number
    staff.save
    render json: staff
  end

  def edit
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
  end

  def update
    render json: params
  end

  private
  def staff_params
    params.require(:store_staff).permit(:first_name, :last_name, :gender, :phone_number)
  end
end
