class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :party, polymorphic: true
  belongs_to :orderable, polymorphic: true

  validates :party_type, :party_id, presence: true
end
