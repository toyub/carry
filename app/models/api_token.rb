class ApiToken < ActiveRecord::Base
  belongs_to :store_staff, foreign_key: "staff_id"

  scope :by_token, ->(token) { where(token: token).last }

  def self.authenticate(authorization)
    find_by(token: authorization)
  end

  def reset_token
    update!(token: SecureRandom.hex(32))
  end
end
