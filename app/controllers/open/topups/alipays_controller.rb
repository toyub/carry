module Open
  class Topups::AlipaysController < Open::BaseController
    before_action :check_params

    # transaction do
    #    create_payment.then.create_debit.then.increase_balance
    #    create_credit.then.decrease_balance.then.finish_order
    # end

    def return_url
      if Alipay.valid_alipay_param?(pure_params.except(:sign, :sign_type), pure_params[:sign], pure_params[:sign_type])
        result = deal_order(pure_params)
        render json: result
      end
    end

    def notify_url
      if Alipay.valid_alipay_param?(pure_params.except(:sign, :sign_type), pure_params[:sign], pure_params[:sign_type])
        result = deal_order(pure_params)
        render json: result
        return 
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

    def deal_order(options)
        order = Order.find_by_pretty_id(options[:out_trade_no])
        payment = Payment.find_or_create_by(payment_method: Alipay.name, order_id: order.id)
        if payment.third_party_params.blank? || !payment.third_party_params.has_key?(:return_url)
          payment.third_party_params = ({return_url: options, return_at: Time.now}).merge(payment.third_party_params || {})
          payment.save
        end
        result = {
                    order: order,
                    payment: payment
                  }
        
        return result
    end
  end
end
