module Open
  class Topups::AlipaysController < Open::BaseController
    before_action :check_params

    # transaction do
    #    create_or_update_payment.then.create_debit.then.increase_balance
    #    create_or_update_order.create_credit.then.decrease_balance.then.finish_order
    #    increase_sms_balance
    # end

    def return_url
      order = Order.find_by_pretty_id(alipay_params[:out_trade_no])
      @payment = save_third_party_params(order, {return_url: alipay_params, return_at: Time.now})
      topup_transaction!(order, @payment)
    end

    def notify_url
      order = Order.find_by_pretty_id(alipay_params[:out_trade_no])
      payment = save_third_party_params(order, {notify_url: alipay_params, notify_at: Time.now})
      topup_transaction!(order, payment)
      render text: 'success'
    end

    private

    def topup_transaction!(order, payment)
      ActiveRecord::Base.transaction do
        unless order.paid
          create_debit(payment)
          create_credit(order)
          increase_sms_balance(order)
          order.paid = true
          order.save
        end
      end
    end

    def save_third_party_params(order, options)
      payment = Payment.find_or_create_by(payment_method_type: PaymentMethods::Alipay.name, order_id: order.id, party: order.party)
      payment.third_party_params = (options).merge(payment.third_party_params || {})
      payment.amount = order.amount
      payment.subject = '使用支付宝付款'
      payment.save
      payment
    end

    def create_credit(order) #Credit has nothing share with payment
      Journalable.create_credit!(order)
    end

    def create_debit(payment) #Debit has nothing share with order
      Journalable.create_debit!(payment)
    end

    def increase_sms_balance(order)
      sms_balance = SmsBalance.find_or_create_by(party: order.party)
      sms_balance.increase_total!(order.order_items.map(&->(item){item.quantity}).sum)
    end

    def alipay_params
      params.except(:action, :controller)
    end

    def check_params
      unless (params.has_key?(:sign) && params.has_key?(:out_trade_no) && params.has_key?(:trade_status))
        render text: 'Some arguments has worg opinion!'
        return false
      end

      unless PaymentMethods::Alipay.valid_alipay_param?(alipay_params.except(:sign, :sign_type), alipay_params[:sign], alipay_params[:sign_type])
        render text: 'Some arguments has worg opinion!'
        return false
      end
    end
  end
end
