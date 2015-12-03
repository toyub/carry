class StoreProtocol < ActiveRecord::Base

  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_staff

  scope :operate_type,  -> (type) { where(type: type) }

  def self.is_new_record?(type)
    operate_type(type).count == 0
  end

end
