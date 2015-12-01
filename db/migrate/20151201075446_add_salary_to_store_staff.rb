class AddSalaryToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :trial_salary, :decimal, precision: 10, scale: 2
    add_column :store_staff, :regular_salary, :decimal, precision: 10, scale: 2
    add_column :store_staff, :previous_salary, :decimal, precision: 10, scale: 2
    add_column :store_staff, :trial_period, :integer
  end
end
