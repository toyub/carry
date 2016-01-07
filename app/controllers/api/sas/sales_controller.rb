class Api::Sas::SalesController < Api::BaseController
  def index
    sales = StoreMonthConsumingSerializer.new.data
    @data = {
      months: sales.keys,
      figures: sales.values
    }
    render json: @data
  end

  def payments
    payments = StoreCustomerPayment.by_month
    @data = StoreMonthConsumingPaymentsSerializer.new(payments).data
    render json: @data
  end

  def categories
    orderitems = StoreOrderItem.by_month
    @data = StoreMonthConsumingCategoriesSerializer.new(orderitems).data
    render json: @data
  end

  def days
    orderitems = StoreOrderItem.by_month
    @data = StoreMonthConsumingDaysSerializer.new(orderitems).data
    render json: @data
  end

end
