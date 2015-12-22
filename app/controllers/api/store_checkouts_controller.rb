module Api
  class StoreCheckoutsController < BaseController

    def create
      order = StoreOrder.find(params[:order_id])
      customer = order.store_customer
      if params[:payments].present?
        save_payments(payment_params[:payments], order,customer)

        render json: {checked:true, msg: 'Checked!'}
      else
        render json: {checked:true, msg: 'Payments required!'}
      end
    end

    def save_payments(payments, order, customer)
      amount = payments.map { |payment| payment[:amount] }.sum
      raise ActiveRecord::Rollback unless order.amount.to_f == amount
      
      payments = order.store_customer_payments.new(payments)
      payments.each do |payment|
        payment.store_customer = customer
      end
      payments
    end

    def order_worker(order)

    end

    def create_credit(order)
      StoreCustomerCredit(store_id: order.store_id,
                          store_chain_id: order.store_chain_id,
                          store_customer_id: order.store_customer_id,
                          store_order_id: order.id,
                          amount: decimal,
                          created_at: datetime,
                          updated_at: datetime)
    end

    private
    def payment_params
      safe_params = params.permit(:order_id, payments: [:payment_method_id, :amount])
      safe_params[:payments].each do |payment_hash|
        payment_hash.merge! store_id: current_staff.store_id,
                            store_chain_id: current_staff.store_chain_id,
                            store_staff_id: current_staff.id
      end

      safe_params
    end

  end
end
