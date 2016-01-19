module Erp
  class StoresController < BaseController
    def index
      params[:q] ||= {}
      if params[:q][:province_code].present?
        if params[:q][:city_code].present?
          merge_params!(params[:q], '城市', :city_code)
        else
          merge_params!(params[:q], '省份', :province_code)
        end
      end
      params[:q].merge!({
        created_at_gteq: DateTime.parse(params[:q][:created_at]).beginning_of_day,
        created_at_lteq: DateTime.parse(params[:q][:created_at]).end_of_day
      })
      params[:q].except!(:province_code, :city_code, :created_at)
      q = current_store_chain.stores.ransack(params[:q])
      @stores = q.result.order('id asc')
      respond_with @stores, location: nil
    end

    private

      def merge_params!(params, category_name, code_type)
        category_id = InfoCategory.find_by(name: category_name).id
        params.merge!({
          store_infos_info_category_id_eq: category_id,
          store_infos_value_eq: params[code_type]
        })
      end
  end
end
