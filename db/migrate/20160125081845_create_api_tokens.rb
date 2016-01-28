class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.string :sn_code
      t.string :token
      t.references :staff

      t.timestamps null: false
    end
  end
end
