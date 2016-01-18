class Api::Sas::SalesController < Api::BaseController

  def index
    render json: StoreMonthConsuming.new(current_store, Time.now.month)
  end

  def payments
    payments = current_store.store_customer_payments.by_month
    render json: StoreMonthConsumingPayments.new(payments)
  end

  def categories
    orderitems = current_store.store_order_items.by_month
    render json: StoreMonthConsumingCategories.new(orderitems)
  end

  def days
    orderitems = current_store.store_order_items.by_month
    render json: StoreMonthConsumingDays.new(orderitems)
  end

end
