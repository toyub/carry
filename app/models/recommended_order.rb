class RecommendedOrder < ActiveRecord::Base
  has_many :items, class_name: 'RecommenedOrderItem'

  before_create :set_numero

  accepts_nested_attributes_for :items

  def self.today
    where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end

  private

    def set_numero
      today_order_count = store.recommended_orders.today.count + 1
      self.numero = Time.now.to_date.to_s(:number) + today_order_count.to_s.rjust(7, '0')
    end
end
