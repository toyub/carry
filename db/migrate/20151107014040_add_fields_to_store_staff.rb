class AddFieldsToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :job_type_id, :integer
    add_column :store_staff, :store_department_id, :integer
    add_column :store_staff, :employeed_at, :datetime
    add_column :store_staff, :terminated_at, :datetime
    add_column :store_staff, :levle_type_id, :integer
    add_column :store_staff, :reason_for_leave, :string
    add_column :store_staff, :numero, :string
  end
end
