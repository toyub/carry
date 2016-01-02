class StoreMaterialLog < ActiveRecord::Base
  include BaseModel

  belongs_to :logged_item, polymorphic: true

  before_validation :set_created_month

  def loggable!(loggable)
    self.logged_item = loggable
    self.save!
    self
  end

  private
  def set_created_month
    self.created_month = Time.now.strftime('%Y%m')
  end
end
