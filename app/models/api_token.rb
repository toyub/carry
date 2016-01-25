class ApiToken < ActiveRecord::Base
  belongs_to :store_staff

  def reset_token
    self.token = "123455677"
  end
end
