class ConstructPerformance
  def initialize(staffs, month)
    @staffs = staffs
    @month = month
    @performances = []
    set_performance_data
  end

  def performances
    @performances
  end

  private
  def set_performance_data
    @staffs.each do |staff|
      commission_history = staff.store_commissions.find_by(created_month: @month.strftime("%Y%m"))
      if commission_history.present?
        @performances << commission_history.commission
      else
        @performances << StaffTypeCommission.find(staff.job_type_id).name.constantize.new(staff, @month).commission if staff.has_commission?
      end
    end
  end
end
