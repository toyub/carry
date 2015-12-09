class ChangeStoreBusinessStatus < ActiveRecord::Migration
  def change
    add_column :stores, :available, :boolean, default: true
  end
end
