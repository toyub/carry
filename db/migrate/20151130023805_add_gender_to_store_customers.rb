class AddGenderToStoreCustomers < ActiveRecord::Migration
  def change
    add_column :store_customers, :gender, :boolean
    add_column :store_customers, :nick, :string
    add_column :store_customers, :resident_id, :string
    add_column :store_customers, :birthday, :date
    add_column :store_customers, :married, :boolean
    add_column :store_customers, :education, :string
    add_column :store_customers, :profession, :string
    add_column :store_customers, :income, :string
    add_column :store_customers, :company, :string
    add_column :store_customers, :tracking_accepted, :boolean
    add_column :store_customers, :message_accepted, :boolean
  end
end
