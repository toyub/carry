class ConstructPerformance
  def initialize(staffs, month)
    @staffs = staffs
    @month = month
    @performances = []
    set_performance_data
  end

  private
  def set_performance_data(month)
    @staffs.each do |staff|
      basic_info = {
        name: staff.screen_name,
        numero: staff.staff.numero,
        department: staff.store_department.try(:name),
        position: staff.store_position.try(:name),
      }
      if commission = staff.store_commissions.find_by(created_month: @month.strftime("%Y%m"))
        commission_info = {
        }
      else

      end


  end

end
