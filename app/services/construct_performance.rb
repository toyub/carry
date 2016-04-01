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
      next unless staff.store_commissions.find_by(created_month: @month.strftime("%Y%m")).present? || staff.has_commission?(@month)
      basic_info = {
        id: staff.id,
        name: staff.screen_name,
        numero: staff.numero,
        department: staff.store_department.try(:name),
        position: staff.store_position.try(:name),
      }
      if commission_history = staff.store_commissions.find_by(created_month: @month.strftime("%Y%m"))
        commission_info = commission_history.commission
      else
        if staff.job_has_commission?
          commission_info = StaffTypeCommission.find(staff.job_type_id).name.constantize.new(staff, @month).commission
        else
          commission_info = StaffOtherCommission.new(staff, @month).commission
        end
      end
      @performances << basic_info.merge(commission_info)
    end
  end
end
