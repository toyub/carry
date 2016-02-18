module V1
  class Stores < Grape::API

    resource :stores do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '门店列表'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :q, type: Hash, default: {} do
          optional :name_cont, type: String, desc: "门店名称"
          optional :province, type: String, desc: "省份code"
          optional :city, type: String, desc: "城市code"
          optional :created_at, type: String, desc: "创建时间"
        end
      end
      get do
        district = params[:q][:city] || params[:q][:province]
        Stores.merge_store_infos!(params[:q], district) if district.present?
        Stores.merge_created_at!(params[:q]) if params[:q][:created_at].present?
        params[:q].except!(:province, :city, :created_at)
        q = current_store_chain.stores.ransack(params[:q])
        present q.result(district: true).order('id asc'), with: ::Entities::Store
      end
    end

    private

      def self.merge_store_infos!(q_params, district)
        name = q_params.has_key?(:city) ? '城市' : '省份'
        q_params.merge!({
          store_infos_info_category_id_eq: InfoCategory.find_by(name: name).id,
          store_infos_value_eq: district
        })
      end

      def self.merge_created_at!(q_params)
        time = Time.zone.parse(q_params[:created_at])
        q_params.merge!({
          created_at_gteq: time.beginning_of_day,
          created_at_lteq: time.end_of_day
        })
      end

  end
end
