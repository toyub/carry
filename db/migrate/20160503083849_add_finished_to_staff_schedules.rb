class AddFinishedToStaffSchedules < ActiveRecord::Migration
  def change
    add_column :staff_schedules, :finished, :boolean, default: false
  end
end
