module BaseModel
  extend ActiveSupport::Concern

  included do
    belongs_to :store
    belongs_to :store_chain
    belongs_to :creator, class_name: 'StoreStaff', foreign_key: :store_staff_id

    validates :store_chain_id, presence: true
    validates :store_id, presence: true
    validates :store_staff_id, presence: true

    before_validation :set_operator
    before_validation :set_store_attrs
  end

  def set_store_attrs
    self.store_id = self.store.id unless self.store_id
    self.store_chain_id = self.store.store_chain_id unless self.store_chain_id
  end

  def set_operator(operator=nil)
    return false if self.store_staff_id.blank? && operator.blank?
    staff = self.creator || operator
    self.store_staff_id = staff.id if self.store_staff_id.blank?
    self.store_id = staff.store.id
    true
  end
end
