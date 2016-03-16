class CheckStaffTerminateJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StoreStaff.all.each do |staff|
      staff.update!(staff_params) if staff.terminated?
    end
  end

  private
  def staff_params
    staff = ActionController::Parameters.new(
      demission: true,
      regular: false,
      mis_login_enabled: false,
      erp_login_enabled: false,
      app_login_enabled: false
    )
    staff.permit(:demission, :regular, :mis_login_enabled, :erp_login_enabled, :app_login_enabled)
  end

end
