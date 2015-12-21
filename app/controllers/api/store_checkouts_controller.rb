module Api
  class StoreCheckoutsController < BaseController

    def create
      order = JSON.parse Mocks::Order.find_by_id(params[:order_id])
      if params[:payments].present?
        save_payments(params[:payments], order)
        Mocks::Order.checked!(params[:order_id])
        render json: {checked:true, msg: 'Checked!'}
      else
        render json: {checked:true, msg: 'Payments required!'}
      end
    end

    def save_payments(payments, order)
      amount = payments.map { |payment| payment[:amount] }.sum
      if order["amount"].to_f == amount
         #payments = StoreCustomerPayment.new(payments)
         p payments
      else
        p amount
      end
      
    end

    def order_worker(order)

    end

  end
end
