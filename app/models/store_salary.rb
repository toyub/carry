class StoreSalary < ActiveRecord::Base
  belongs_to :store_staff

  scope :without_confirm_salary_of_this_month, -> { where("created_at > ? and status = false", Time.now.beginning_of_month) }
end
