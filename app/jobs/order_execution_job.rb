class OrderExecutionJob < ActiveJob::Base
  queue_as :default

  def perform(order_id)
    order = StoreOrder.find_by(id: order_id)
    order.execute! if order
  end
end
