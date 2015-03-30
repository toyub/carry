class StoreMaterialCommission < ActiveRecord::Base
    belongs_to :store
    belongs_to :store_chain
    belongs_to :creator, class_name: 'Staff', foreign_key: 'store_staff_id'

  def initialize(*args, &block)
    raise NotImplementedError, "#{self.class} is an abstract class and cannot be instantiated." if self.class == StoreMaterialCommission
    super
  end
end