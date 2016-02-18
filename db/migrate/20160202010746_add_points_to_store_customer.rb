class AddPointsToStoreCustomer < ActiveRecord::Migration
  def change
    add_column :store_customers, :points, :Integer
  end
end
