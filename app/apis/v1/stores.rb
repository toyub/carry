module V1
  class Stores < Grape::API

    resource :stores do
      add_desc '门店列表'
      before do
        authenticate_user!
      end

      params do
        optional :q, type: Hash, default: {} do
          optional :name_cont, type: String, desc: "门店名称"
          optional :province, type: String, desc: "省份code"
          optional :city, type: String, desc: "城市code"
          optional :created_at, type: String, desc: "创建时间"
        end
      end
      get do
        params[:q] ||= {}
        district = params[:q][:province] || params[:q][:city]
        merge_store_infos!(params[:q], district) if district.present?
        merge_created_at! if params[:q][:created_at].present?
        params[:q].except!(:province, :city, :created_at)
        q = current_store_chain.stores.ransack(params[:q])
        present q.result.order('id asc'), with: ::Entities::Store
      end
    end

    private

      def merge_store_infos!(q_params, district)
        code = q_params.has_key?(:province) ? 'province' : 'city'
        q_params.merge!({
          store_infos_info_category_id_eq: InfoCategory.find_by(code: code).id,
          store_infos_value_eq: district
        })
      end

      def merge_created_at!(q_params)
        time = Time.zone.parse(q_params[:created_at])
        q_params.merge!({
          created_at_gteq: time.beginning_of_day,
          created_at_lteq: time.end_of_day
        })
      end

  end
end
