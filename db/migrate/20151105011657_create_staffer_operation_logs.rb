class CreateStafferOperationLogs < ActiveRecord::Migration
  def change
    create_table :staffer_operation_logs do |t|
      t.integer :resource_id
      t.string :resource_type
      t.integer :staffer_id
      t.json :log

      t.timestamps
    end
  end
end
