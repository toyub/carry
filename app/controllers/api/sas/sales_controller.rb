class Api::Sas::SalesController < Api::BaseController
  before_action :set_store

  def index
    sales = StoreMonthConsumingSerializer.new(@store, Time.now.month).data
    @data = {
      months: sales.keys,
      figures: sales.values
    }
    render json: @data
  end

  def payments
    payments = @store.store_customer_payments.by_month
    @data = StoreMonthConsumingPaymentsSerializer.new(payments).data
    render json: @data
  end

  def categories
    orderitems = @store.store_order_items.by_month
    @data = StoreMonthConsumingCategoriesSerializer.new(orderitems).data
    render json: @data
  end

  def days
    orderitems = @store.store_order_items.by_month
    @data = StoreMonthConsumingDaysSerializer.new(orderitems).data
    render json: @data
  end

  private
  def set_store
    @store = Store.find_by_id(params[:id]) || current_store
  end

end
