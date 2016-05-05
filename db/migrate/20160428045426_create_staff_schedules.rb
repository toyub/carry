class CreateStaffSchedules < ActiveRecord::Migration
  def change
    create_table :staff_schedules do |t|
      t.integer :store_staff_id
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.text :remark

      t.timestamps null: false
    end
  end
end
