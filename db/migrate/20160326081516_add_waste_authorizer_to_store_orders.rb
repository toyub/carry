class AddWasteAuthorizerToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :deleted_authorizer_id, :integer, comment: '授权人'
    add_column :store_orders, :deleted_operator_id, :integer, comment: '操作员'
    add_column :store_orders, :deleted_reason, :string
    add_column :store_orders, :deleted_at, :datetime
  end
end
