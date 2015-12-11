class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :journal_entry_id
      t.decimal :amount,                    precision: 10,              scale: 2
      t.string  :subject
      t.integer :order_id

      t.datetime  :created_at
      t.datetime  :updated_at

    end
  end
end
