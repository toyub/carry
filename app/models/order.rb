class Order < ActiveRecord::Base
  include PrettyIdable

  belongs_to :party, polymorphic: true
  has_many :order_items

  validates :party_type, :party_id, presence: true

  before_create :set_numero

  private
  def set_numero
    sequence = Order.where('created_at between ? and ?', Time.now.beginning_of_day, Time.now.end_of_day).count + 1
    self.numero = "#{Time.now.strftime('%Y%m%d')}#{sequence.to_s.rjust(7, '0')}"
  end
end
