class OrderExecutionJob < ActiveJob::Base
  queue_as :default

  def perform(order_id)
    order = StoreOrder.find(order_id)
    order.execute!
  end
end
