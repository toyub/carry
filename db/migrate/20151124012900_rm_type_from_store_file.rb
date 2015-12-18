class RmTypeFromStoreFile < ActiveRecord::Migration
  def change
    remove_column :store_files, :type, :string
  end
end
