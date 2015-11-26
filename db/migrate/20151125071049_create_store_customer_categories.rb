class CreateStoreCustomerCategories < ActiveRecord::Migration
  def change
    create_table :store_customer_categories do |t|
      t.integer   :store_id,                null: false
      t.integer   :store_chain_id,          null: false
      t.integer   :store_staff_id,          null: false
      t.string    :name,                    null: false
      t.string    :description
      t.string    :color
      t.boolean   :auto_promoted_enabled,   default: false
      t.json      :conditions
      t.json      :discounts
      t.json      :privileges

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
