class ChangeDefaultValueOfInsurenceInStoreSalaries < ActiveRecord::Migration
  def change
    change_column_default :store_salaries, :insurence, {}
  end
end
