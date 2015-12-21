class RenameStoreProtocolsColumn < ActiveRecord::Migration
  def change
    rename_column :store_protocols, :reason_for, :reason
    rename_column :store_protocols, :remarks, :remark
    rename_column :store_protocols, :effective_date, :effected_on
    rename_column :store_protocols, :end_at, :expired_on
    rename_column :store_protocols, :created_by, :applicant_id

    remove_column :store_protocols, :record_at
  end
end
