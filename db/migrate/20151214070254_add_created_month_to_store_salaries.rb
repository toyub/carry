class AddCreatedMonthToStoreSalaries < ActiveRecord::Migration
  def change
    add_column :store_salaries, :created_month, :string
  end
end
