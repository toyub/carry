class Api::Sas::SalesController < Api::BaseController

  def index
    render json: Sas::MonthConsuming.new(current_store, Time.now.month)
  end

  def payments
    payments = current_store.store_customer_payments.by_month
    render json: Sas::MonthConsumingPayments.new(payments)
  end

  def categories
    orderitems = current_store.store_order_items.by_month
    render json: Sas::MonthConsumingCategories.new(orderitems)
  end

  def days
    orderitems = current_store.store_order_items.by_month
    render json: Sas::MonthConsumingDays.new(orderitems)
  end

end
