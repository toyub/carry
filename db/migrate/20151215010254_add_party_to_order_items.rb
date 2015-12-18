class AddPartyToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :party_type, :string
    add_column :order_items, :party_id, :integer
  end
end
