module Api
  class StoreCheckoutsController < BaseController

    def create
      order = Mocks::Order.find_by_id(params[:order_id])
      if params[:payments].present?
        save_payments(params[:payments])
        Mocks::Order.checked!(params[:order_id])
        render json: {checked:true, msg: 'Checked!'}
      else
        render json: {checked:true, msg: 'Payments required!'}
      end
    end

    def save_payments(payments)

    end

    def order_worker(order)

    end

  end
end
