class CreateRepaymentService
  include Serviceable

  def initialize(form_params, customer)
    @form = form_params
    @customer = customer
    @repayment_params = @form.except(:orders, :total)
    @total = @form[:total].to_f
  end

  def call
    if @total <= 0
      return false
    end
    ActiveRecord::Base.transaction do
      repayment = StoreRepayment.create(@repayment_params.merge(amount: @total))
      @customer.orders.where(id: @form[:orders]).each do |order|
        remaining = @total - order.repayment_remaining
        if remaining <= 0
          filled = @total
        else
          filled = order.repayment_remaining
        end
        order.store_order_repayments.create!(filled: filled, remaining: order.repayment_remaining - filled, store_repayment: repayment)
        order.repay!(filled)
        @total = remaining
        if @total <= 0
          break
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

end
