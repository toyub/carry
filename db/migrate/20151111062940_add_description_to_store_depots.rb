class AddDescriptionToStoreDepots < ActiveRecord::Migration
  def change
    add_column :store_depots, :deleted, :boolean, default: false
    add_column :store_depots, :preferred, :boolean, default: false
    add_column :store_depots, :useable, :boolean,  default: true
    add_column :store_depots, :admin_ids, :integer, array: true
    add_column :store_depots, :description, :string
  end
end
