class StoreSalary < ActiveRecord::Base
  belongs_to :store_staff

  scope :without_confirm_salary_of_this_month, -> { where(created_month: Time.now.strftime("%Y%m")) }

  def checked?
    self.status
  end

  def self.total_amount
    all.inject(0) { |sum, salary| sum += salary.salary_actual_pay }
  end
end
