class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :party, polymorphic: true
  validates :party_type, :party_id, presence: true

  def orderable
    self.orderable_type.constantize.find(self.orderable_id)
  end
end
