class AddOccurAtToStoreEvents < ActiveRecord::Migration
  def change
    add_column :store_events, :occur_on, :datetime
    add_column :store_events, :start_on, :datetime
    add_column :store_events, :end_on, :datetime
    add_column :store_events, :occur_at, :string
  end
end
