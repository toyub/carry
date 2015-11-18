class AddLoginNameAndNameToStaffer < ActiveRecord::Migration
  def change
    add_column :staffers, :family_name, :string
    add_column :staffers, :name, :string
    add_column :staffers, :login_name, :string
  end
end
