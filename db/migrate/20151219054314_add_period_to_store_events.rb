class AddPeriodToStoreEvents < ActiveRecord::Migration
  def change
    add_column :store_events, :period, :integer
  end
end
