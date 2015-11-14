class CreateStorePackageTrackings < ActiveRecord::Migration
  def change
    create_table :store_package_trackings do |t|
      t.integer :mode, defalut: 0
      t.integer  :store_id
      t.integer  :store_chain_id
      t.integer  :store_staff_id
      t.integer  :store_package_id
      t.boolean  :notice_required, default: false
      t.string   :content
      t.integer  :delay_interval, default: 0
      t.integer  :delay_unit
      t.integer  :trigger_timing

      t.timestamps null: false
    end
  end
end
