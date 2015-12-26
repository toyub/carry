class CreateRepaymentService
  include Serviceable

  def initialize(form_params, customer, repayment)
    @form_params = form_params
    @customer = customer
    @repayment = repayment
    @total = @form_params[:total].to_i
  end

  def call
    @repayment.transaction do
      @customer.orders.where(id: @form_params[:orders]).each do |order|
        remaining = @total - order.repayment_remaining
        if remaining >= 0
          @total = remaining
          order.repayment_finished!
          order.store_order_repayments.create(filled: order.repayment_remaining, remaining: 0.0, store_repayment: @repayment)
        else
          order.update(filled: order.filled + @total)
          order.store_order_repayments.create(filled: @total, remaining: order.repayment_remaining, store_repayment: @repayment  )
          break
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
