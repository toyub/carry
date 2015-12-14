class Payment < ActiveRecord::Base
  belongs_to :party, polymorphic: true

  validates :party_type, :party_id, presence: true
end
