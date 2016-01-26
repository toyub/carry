class ApiToken < ActiveRecord::Base
  belongs_to :store_staff

  validates :sn_code, presence: true

  def reset_token
    self.token = SecureRandom.hex(32)
  end
end
