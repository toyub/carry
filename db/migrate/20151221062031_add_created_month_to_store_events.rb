class AddCreatedMonthToStoreEvents < ActiveRecord::Migration
  def change
    add_column :store_events, :created_month, :string, default: "201512"
  end
end
