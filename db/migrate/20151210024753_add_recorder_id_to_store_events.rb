class AddRecorderIdToStoreEvents < ActiveRecord::Migration
  def change
    add_column :store_events, :recorder_id, :integer
  end
end
