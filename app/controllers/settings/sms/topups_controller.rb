module Settings
  class Sms::TopupsController < BaseController
    def index
      @topups = OrderItem.joins(:order)
                         .where(orderable_type: SmsTopup.name)
                         .where('orders.party_type': Store.name, 'orders.party_id': current_store.id, 'orders.paid': true)
                         .order('created_at desc')
    end

    def new
      if params[:quantity].to_i < 1
        render text: '参数错误'
        return false
      end
      order = Order.new(party_type: Store.name, party_id:current_store.id)
      order_item = order.order_items.new(SmsTopup.new(params[:quantity].to_i).to_h)
      order_item.amount = order_item.price * order_item.quantity

      order.subject = "短信充值费用#{order_item.amount}元"
      order.amount = order.order_items.map(&->(item){item.amount}).sum
      order.save
      order_item.save
      alipay = Alipay.new(order)
      redirect_to alipay.url
    end
  end
end
