module Open
  class Topups::AlipaysController < Open::BaseController
    before_action :check_params

    # transaction do
    #    create_payment.then.create_debit.then.increase_balance
    #    create_credit.then.decrease_balance.then.finish_order
    # end

    def return_url
      if Alipay.valid_alipay_param?(pure_params.except(:sign, :sign_type), pure_params[:sign], pure_params[:sign_type])
        order = Order.find_by_pretty_id(pure_params[:out_trade_no])
        payment = save_return_url(order, pure_params)
        render json: {order: order,payment: payment}
      end
    end

    def notify_url
      if Alipay.valid_alipay_param?(pure_params.except(:sign, :sign_type), pure_params[:sign], pure_params[:sign_type])
        order = Order.find_by_pretty_id(pure_params[:out_trade_no])
        payment = save_notify_url(order, pure_params)
        create_debit(payment)
        create_credit(order)

        puts "\n"*8
        p ({order: order, payment: payment})
        puts "\n"
      end
      render text: 'success'
    end

    private
    def pure_params
      params.except(:action, :controller)
    end

    def check_params
      unless (params.has_key?(:sign) && params.has_key?(:out_trade_no) && params.has_key?(:trade_status))
        render text: 'Some arguments has worg opinion!'
      end
    end

    def save_return_url(order, options)
      payment = Payment.find_or_create_by(payment_method: Alipay.name, order_id: order.id)
      if payment.third_party_params.blank? || !payment.third_party_params.has_key?(:return_url)
        payment.third_party_params = ({return_url: options, return_at: Time.now}).merge(payment.third_party_params || {})
        payment.save
      end
      payment
    end

    def save_notify_url(order, options)
      payment = Payment.find_or_create_by(payment_method: Alipay.name, order_id: order.id)
      if payment.third_party_params.blank? || !payment.third_party_params.has_key?(:notify_url)
        payment.third_party_params = ({notify_url: options, notify_at: Time.now}).merge(payment.third_party_params || {})
        payment.save
      end
      payment
    end

    def create_credit(order) #Credit has nothing share with payment
      credit = Credit.create(party: order.party, amout: order.amount, subject: order.subject)
      journal_entry = JournalEntry.create(party)
      journal_entry.party.decrease_balance_cache(credit.amount)
    end

    def create_debit(payment) #Debit has nothing share with order
      debit = Debit.create(party: payment.party, amout: payment.amout, subject: payment.payment_method.name)
      journal_entry =  JournalEntry.create(party)
      journal_entry.party.increase_balance_cache(debit.amout)
    end
  end
end
