module Open
  class Topups::AlipaysController < Open::BaseController
    def return_url
      order = Order.find(params[:out_trade_no])
      if order.present?
        if params[:is_success].to_s.upcase == 'T' || params[:is_success].to_s.upcase == 'TRUE'
          if Alipay.valid_alipay_param?(pure_params.except(:sign, :sign_type), pure_params[:sign], params[:sign_type])
            render json: pure_params
          else
            render json: {
              params: params,
              pure_params: pure_params,
              sign_params: pure_params.except(:sign, :sign_type)
            }
          end
          
        else
          render json: pure_params
        end
      else
        render text: ''
      end
    end

    def notify_url
      
      render text: 'success'
    end

    private
    def pure_params
      params.except(:action, :controller)
    end
  end
end
