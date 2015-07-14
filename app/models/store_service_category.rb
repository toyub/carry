class StoreServiceCategory < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { scope: :store_id }
  validates :store_chain_id, presence: true

  belongs_to :store

  before_validation :set_store_chain

  private
  def set_store_chain
    self.store_chain_id = self.store.store_chain_id
  end
end
