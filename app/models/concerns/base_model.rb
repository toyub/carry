module BaseModel
  extend ActiveSupport::Concern

  included do
    belongs_to :store
    belongs_to :store_chain

    validates :store_chain_id, presence: true
    validates :store_id, presence: true

    before_validation :set_store_attrs
  end

  def set_store_attrs
    self.store_id = self.store.id unless self.store_id
    self.store_chain_id = self.store.store_chain_id unless self.store_chain_id
  end
end
