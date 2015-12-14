module Open
  class Topups::AlipaysController < Open::BaseController
    before_action :check_params

    # transaction do
    #    create_payment.then.create_debit.then.increase_balance
    #    create_credit.then.decrease_balance.then.finish_order
    # end

    def return_url
      if Alipay.valid_alipay_param?(alipay_params.except(:sign, :sign_type), alipay_params[:sign], alipay_params[:sign_type])
        topup_transaction!(alipay_params)
      end
    end

    def notify_url
      if Alipay.valid_alipay_param?(alipay_params.except(:sign, :sign_type), alipay_params[:sign], alipay_params[:sign_type])
        topup_transaction!(alipay_params)
      end
      render text: 'success'
    end

    private

    def topup_transaction!(pure_params)
      ActiveRecord::Base.transaction do
        order = Order.find_by_pretty_id(pure_params[:out_trade_no])
        payment = save_notify_url(order, pure_params)
        unless order.paid
          create_debit(payment)
          create_credit(order)
          order.paid = true
          order.save
        end
      end
    end

    def alipay_params
      params.except(:action, :controller)
    end

    def check_params
      unless (params.has_key?(:sign) && params.has_key?(:out_trade_no) && params.has_key?(:trade_status))
        render text: 'Some arguments has worg opinion!'
      end
    end

    def save_return_url(order, options)
      save_third_party_params(order, {return_url: options, return_at: Time.now})
    end

    def save_notify_url(order, options)
      save_third_party_params(order, {notify_url: options, notify_at: Time.now})
    end

    def save_third_party_params(order, options)
      payment = Payment.find_or_create_by(payment_method: Alipay.name, order_id: order.id, party: order.party)
      payment.third_party_params = (options).merge(payment.third_party_params || {})
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
  end
end
