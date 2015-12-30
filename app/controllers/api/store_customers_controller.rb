module Api
  class StoreCustomersController < BaseController
    def index
      @q = current_store.store_customers.ransack(params[:q])
      @customers = @q.result.select("DISTINCT ON (store_customers.id) store_customers.*")
      respond_with @customers, location: nil
    end

    def create
      @customer = current_store.store_customers.create(append_store_attrs customer_params)
      respond_with @customer, location: nil
    end

    def show
      @customer = current_store.store_customers.find(params[:id])
      respond_with @customer, location: nil
    end

    private
      def customer_params
        params.require(:store_customer).permit(
          :first_name,
          :last_name,
          :nick,
          :contact,
          :telephone,
          :mobile,
          :gender,
          :address,
          :resident_id,
          :district,
          :birthday,
          :range,
          :married,
          :education,
          :profession,
          :income,
          :hobby,
          :smoking,
          :drinking,
          :company,
          :tracking_accepted,
          :message_accepted,
          :settlement_mode,
          :settlement_interval,
          :contract,
          :bank,
          :bank_account,
          :tax,
          :payment_mode,
          :invoice_category,
          :invoice_title,
          :credit_limit,
          :remark,
          :qq
        )
      end

  end
end
