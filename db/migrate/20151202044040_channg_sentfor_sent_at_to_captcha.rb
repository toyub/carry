class ChanngSentforSentAtToCaptcha < ActiveRecord::Migration
  def change
    remove_column :captchas, :sent, :datetime
    add_column :captchas, :sent_at, :datetime
  end
end
