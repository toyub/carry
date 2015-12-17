class Payment < ActiveRecord::Base
  belongs_to :party, polymorphic: true
  has_one :debit
  validates :party_type, :party_id, presence: true
  belongs_to :order

  def payment_method
    self.payment_method_type.constantize
  end
end
