class Order < ActiveRecord::Base
  has_many :order_items

  def numero
    self.id
  end

  def set_party(party)
    self.party_type = party.class.name
    self.party_id = party.id
  end
end
