class Settings::PrivilegesController < Settings::BaseController
  def index
    @staff = current_store.store_staff
  end

end
