class AddAvailableToStoreWorkstations < ActiveRecord::Migration
  def change
    add_column :store_workstations, :available, :boolean, defalut: true
    add_column :store_workstations, :color, :string
  end
end
