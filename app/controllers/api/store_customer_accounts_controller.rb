module Api
  class StoreCustomerAccountsController < BaseController
    def show
      store_customer = StoreCustomer.find(params[:id])
      render json: store_customer
    end

    def expense
      store_customer = StoreCustomer.find(params[:id])
      captcha = $redis.get("sms.captcha.pos.pay-#{store_customer.phone_number}")
      if captcha.present? && captcha == params[:authentication_code]
        amount = params[:amount].to_f
        order = store_customer.orders.available.find(params[:order_id])
        if order.paid?
          render json: {valid: true, paid: true}
        else
          respond_with StoreCustomerDepositExpense.expense!(store_customer, order, amount), location: nil
        end
      else
        render json: {valid: false, msg: 'Illegal authentication code'}
      end
    end
  end
end
