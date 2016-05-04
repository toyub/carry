class CreateSystemNarrators < ActiveRecord::Migration
  def change
    create_table :system_narrators do |t|
      t.string   :type
      t.integer  :extra_id

      t.timestamps null: false
    end

    add_index :system_narrators, [:type, :extra_id]
  end
end
