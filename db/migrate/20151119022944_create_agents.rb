class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.integer :staffer_id
      t.integer :quota
      t.decimal :balance
      t.string :charge_area
      t.string :company_name
      t.string :company_address
      t.string :phone_number
      t.string :cooperation_way
      t.text :remark
    end
  end
end
