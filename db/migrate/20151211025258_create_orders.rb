class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string    :numero
      t.string    :party_type
      t.integer   :party_id
      t.string    :subject
      t.decimal   :amount,                      precision: 10,              scale: 2,               comment: 'amount = sum(order_items.amount)'
      t.integer   :staffer_id

    end
  end
end
