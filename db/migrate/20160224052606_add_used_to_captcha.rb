class AddUsedToCaptcha < ActiveRecord::Migration
  def change
    add_column :captchas, :used, :boolean, default: false
    add_column :captchas, :switch_type_id, :integer, default: 1
  end
end
