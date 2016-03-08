module Api
  class StoreCheckoutsController < BaseController
    before_action :check_params

    def create
      order = StoreOrder.find(params[:order_id])
      paid_amount = payment_params[:payments].map { |payment| payment[:amount].to_f  }.sum
      if(order.amount != paid_amount)
        render json: {checked: false, msg: 'Payments amount is not equal!'}
        return
      end

      if(StoreOrderArchive.new(fill_payments_with_order(payment_params[:payments], order), order).reform)
        order.cashier = current_staff
        order.settle_down
        order.save!
        OrderTrackingJob.perform_later order if order.store_customer.tracking_accepted
        render json: {checked: true, msg: 'Checked!'}
      else
        render json: {checked: false, msg: 'System error!'}
      end
    end

    private
    def payment_params
      safe_params = params.permit(:order_id, payments: [:payment_method_id, :amount, :payment_method_type])
      safe_params[:payments].reject!(&->(payment){ payment[:payment_method_type].blank? || payment[:amount].to_f <= 0})
      safe_params[:payments].each do |payment_hash|
        payment_hash.merge! store_id: current_staff.store_id,
                            store_chain_id: current_staff.store_chain_id,
                            store_staff_id: current_staff.id
      end

      safe_params
    end

    def fill_payments_with_order(safe_params, order)
      safe_params.each do |payment_hash|
        payment_hash.merge! store_order_id: order.id,
                            store_customer_id: order.store_customer_id
      end

      safe_params
    end

    def check_params
      if params[:payments].blank?
        render json: {checked: false, msg: 'Payments required!'}
        return false
      end
    end

  end
end
