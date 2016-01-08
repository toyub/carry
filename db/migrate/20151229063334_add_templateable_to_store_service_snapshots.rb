class AddTemplateableToStoreServiceSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_snapshots, :templateable_id, :integer
    add_column :store_service_snapshots, :templateable_type, :string
  end
end
