class Order < ActiveRecord::Base
  include PrettyIdable

  belongs_to :party, polymorphic: true
  has_many :order_items

  validates :party_type, :party_id, presence: true

  before_create :set_numero

  has_many :payments

  def payments_methods
    self.payments.map(&->(payment){ payment.payment_method.cn_name }).join(', ')
  end

  private
  def set_numero
    sequence = Order.where('created_at between ? and ?', Time.now.beginning_of_day, Time.now.end_of_day).count + 1
    self.numero = "#{Time.now.strftime('%Y%m%d')}#{sequence.to_s.rjust(7, '0')}"
  end
end
