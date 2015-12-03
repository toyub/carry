class CreateCaptcha < ActiveRecord::Migration
  def change
    create_table :captchas do |t|
      t.string :phone
      t.string :token
      t.datetime :sent
    end
  end
end
