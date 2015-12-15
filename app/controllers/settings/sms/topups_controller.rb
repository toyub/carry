module Settings
  class Sms::TopupsController < BaseController
    def index
      from, to = query_date
      @topups = OrderItem.joins(:order)
                         .where(orderable_type: SmsTopup.name)
                         .where(party: current_store)
                         .where(orders:{paid: true})
                         .where('orders.created_at between ? and ?', "#{from.to_s(:db)} 00:00:00", "#{to.to_s(:db)} 23:59:59")
                         .order('orders.created_at desc')
      @sms_balance = current_store.sms_balance
    end

    def new
      if params[:quantity].to_i < 200
        render text: '参数错误'
        return false
      end
      order = Order.create(party: current_store)
      order_item = order.order_items.create(SmsTopup.new(params[:quantity].to_i).to_h.merge(party: order.party))
      order.amount = order.order_items.map(&->(item){item.amount}).sum
      order.subject = "短信充值费用#{order.amount}元"
      order.save
      alipay = PaymentMethods::Alipay.new(order)
      redirect_to alipay.url
    end

  end
end
