class AddSituationToStoreOrder < ActiveRecord::Migration
  def change
    add_column :store_orders, :situation, :json
  end
end
