class AddSaltToCaptchas < ActiveRecord::Migration
  def change
    add_column :captchas, :verification, :string
    add_column :captchas, :token_available, :boolean, default: true
    rename_column :captchas, :used, :verification_used
  end
end
