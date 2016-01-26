class SmsBalance < ActiveRecord::Base
  belongs_to :party, polymorphic: true
  validates :party_type, :party_id, presence: true

  scope :by_store, ->{ where(party_type: 'Store') }

  def remaining
    self.total-self.sent_quantity
  end

  def increase_total!(quantity)
    self.class.unscoped.where(id: self.id).update_all("total=COALESCE(total, 0) + #{quantity.to_i.abs}")
  end

  def increase_total!(quantity)
    self.class.unscoped.where(id: self.id).update_all("total=COALESCE(total, 0) + #{quantity.to_i.abs}")
  end

  def increase_sent_quantity!(quantity)
    self.class.unscoped.where(id: self.id).update_all("sent_quantity=COALESCE(sent_quantity, 0) + #{quantity.to_i.abs}")
  end

  def left_quantity
    self.total.to_i - self.sent_quantity.to_i
  end
end
