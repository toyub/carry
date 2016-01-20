class Api::Sas::SalesController < Api::BaseController

  def index
    render json: Sas::MonthConsuming.new(current_store, Time.now.month)
  end

  def payments
    render json: Sas::MonthConsumingPayments.new(current_store)
  end

  def categories
    render json: Sas::MonthConsumingCategories.new(current_store)
  end

  def days
    render json: Sas::MonthConsumingDays.new(current_store)
  end

end
