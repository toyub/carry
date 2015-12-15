module Settings
  class Sms::TopupsController < BaseController
    def index
      @topups = OrderItem.joins(:order)
                         .where(orderable_type: SmsTopup.name)
                         .where(party: current_store)
                         .where(orders:{paid: true})
                         .order('created_at desc')
    end

    def new
      if params[:quantity].to_i < 1
        render text: '参数错误'
        return false
      end
      order = Order.new(party: current_store)
      order_item = order.order_items.create(SmsTopup.new(params[:quantity].to_i).to_h.merge(party: order.party))
      order.amount = order.order_items.map(&->(item){item.amount}).sum
      order.subject = "短信充值费用#{order_item.amount}元"
      order.save
      alipay = Alipay.new(order)
      redirect_to alipay.url
    end
  end
end
