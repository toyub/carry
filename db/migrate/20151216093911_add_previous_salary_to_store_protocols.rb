class AddPreviousSalaryToStoreProtocols < ActiveRecord::Migration
  def change
    add_column :store_protocols, :previous_salary, :decimal, precision: 10, scale: 2
    add_column :store_protocols, :new_salary, :decimal, precision: 10, scale: 2
  end
end
