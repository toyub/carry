class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer   :order_id
      t.string    :orderable_type
      t.integer   :orderable_id
      t.integer   :quantity,              null: false
      t.decimal   :price,                 null: false,          precision: 6,         scale: 2
      t.decimal   :amount,                null: false,          precision: 8,         scale: 2,         comment: 'amount = price * quantity'

    end
  end
end
