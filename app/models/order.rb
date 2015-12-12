class Order < ActiveRecord::Base
  include PrettyIdable

  has_many :order_items

  before_create :set_numero

  def set_party(party)
    self.party_type = party.class.name
    self.party_id = party.id
  end

  private
  def set_numero
    sequence = Order.where('created_at between ? and ?', Time.now.beginning_of_day, Time.now.end_of_day).count + 1
    self.numero = "#{Time.now.strftime('%Y%m%d')}#{sequence.to_s.rjust(7, '0')}"
  end
end
