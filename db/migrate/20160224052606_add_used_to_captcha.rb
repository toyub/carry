class AddUsedToCaptcha < ActiveRecord::Migration
  def change
    add_column :captchas, :used, :boolean, default: false
  end
end
