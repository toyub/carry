module Api
  class StoreCustomerEntitiesController < BaseController
    def index
      @q = current_store.store_customer_entities.ransack(params[:q])
      @entities = @q.result.select("DISTINCT ON (store_customer_entities.id) store_customer_entities.*")
      respond_with @entities, location: nil
    end

    def create
      @entity = current_store.store_customer_entities.create(append_store_attrs entity_params)
      respond_with @entity, location: nil
    end

    def show
      @entity = current_store.store_customer_entities.find(params[:id])
      respond_with @entity, location: nil
    end

    private
      def entity_params
        params.require(:store_customer_entity).permit(
          :telephone,
          :mobile,
          :qq,
          :district,
          :address,
          :range,
          :remark,
          :store_customer_category_id,
          store_customer_attributes: [
            :first_name,
            :last_name,
            :gender,
            :nick,
            :resident_id,
            :birthday,
            :married,
            :education,
            :profession,
            :income,
            :company,
            :tracking_accepted,
            :message_accepted
          ],
          store_customer_settlement: [
            :bank,
            :bank_account,
            :credit,
            :credit_amount,
            :notice_required,
            :contract,
            :tax,
            :payment_mode,
            :invoice_type,
            :invoice_title
          ]
        )
      end

  end
end