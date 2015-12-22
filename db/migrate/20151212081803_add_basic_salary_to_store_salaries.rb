class AddBasicSalaryToStoreSalaries < ActiveRecord::Migration
  def change
    add_column :store_salaries, :basic_salary, :decimal, precision: 8, scale: 2, default: 0
  end
end
