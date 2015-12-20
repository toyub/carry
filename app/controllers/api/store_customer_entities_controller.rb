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

    def update
      @entity = current_store.store_customer_entities.find(params[:id])
      @entity.update(append_store_attrs entity_params)
      respond_with @entity, location: nil
    end

    def show
      @entity = current_store.store_customer_entities.find(params[:id])
      respond_with @entity, location: nil
    end

    def cities
      @cities = Geo.cities(1, params[:province])
      respond_with @cities, location: nil
    end

    def regions
      @regions = Geo.regions(1, params[:province], params[:city])
      respond_with @regions, location: nil
    end

    private
      def entity_params
        params.require(:store_customer_entity).permit(
          :address,
          :range,
          :remark,
          :store_customer_category_id,
          district: [:province, :city, :region],
          store_customer_attributes: [
            :id,
            :telephone,
            :phone_number,
            :qq,
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
          store_customer_settlement_attributes: [
            :id,
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
