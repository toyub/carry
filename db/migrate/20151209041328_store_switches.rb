class StoreSwitches < ActiveRecord::Migration
  def change
    create_table :store_switches do |t|
      t.integer   :store_id
      t.integer   :store_chain_id
      t.integer   :store_staff_id
      t.integer   :switchable_id
      t.integer   :switchable_type
      t.boolean   :enabled,           default: false

      t.datetime  :created_at
      t.datetime  :updated_at
    end
  end
end
