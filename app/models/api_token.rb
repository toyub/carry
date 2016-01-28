class ApiToken < ActiveRecord::Base
  belongs_to :store_staff, foreign_key: "staff_id"

  validates :sn_code, presence: true

  def self.authenticate(sn_code, authorization)
    find_by(sn_code: sn_code, token: authorization)
  end

  def reset_token
    update!(token: SecureRandom.hex(32))
  end
end
