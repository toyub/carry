class Api::Sas::SalesController < Api::BaseController

  def index
    sales = StoreMonthConsumingSerializer.new(current_store, Time.now.month).data
    @data = {
      months: sales.keys,
      figures: sales.values
    }
    render json: @data
  end

  def payments
    payments = current_store.store_customer_payments.by_month
    @data = StoreMonthConsumingPaymentsSerializer.new(payments).data
    render json: @data
  end

  def categories
    orderitems = current_store.store_order_items.by_month
    @data = StoreMonthConsumingCategoriesSerializer.new(orderitems).data
    render json: @data
  end

  def days
    orderitems = current_store.store_order_items.by_month
    @data = StoreMonthConsumingDaysSerializer.new(orderitems).data
    render json: @data
  end

end
