class Soa::SettingController < Soa::ControllerBase
  def show
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
  end
end
