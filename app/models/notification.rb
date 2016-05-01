class Notification < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  has_many :envelopes, as: :message, dependent: :delete_all
end
