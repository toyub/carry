class CreateStoreSalaries < ActiveRecord::Migration
  def change
    create_table :store_salaries do |t|
      t.integer :store_staff_id
      t.decimal :amount_deduction, precision: 8, scale: 2
      t.json :deduction, default: {}
      t.decimal :amount_overtime, precision: 8, scale: 2
      t.decimal :amount_reward, precision: 8, scale: 2
      t.decimal :amount_bonus, precision: 8, scale: 2
      t.json :bonus, default: {}
      t.decimal :amount_insurence, precision: 8, scale: 2
      t.json :insurence
      t.decimal :amount_cutfee, precision: 8, scale: 2
      t.decimal :amount_should_cutfee, precision: 8, scale: 2
      t.json :cutfee, default: {}
      t.decimal :salary_should_pay, precision: 8, scale: 2
      t.decimal :salary_actual_pay, precision: 8, scale: 2
      t.boolean :status, default: false

      t.timestamps null: false
    end
  end
end
