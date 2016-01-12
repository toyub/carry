module Erp
  class StoresController < BaseController
    def index
      if params[:q][:province_code].present?
        if params[:q][:city_code].present?
          city_code = params[:q][:city_code]
          category_id = InfoCategory.find_by(name: '城市').id
          params[:q].merge!({
            store_infos_info_category_id_eq: category_id,
            store_infos_value_eq: city_code
          })
        else
          province_code = params[:q][:province_code]
          category_id = InfoCategory.find_by(name: '省份').id
          params[:q].merge!({
            store_infos_info_category_id_eq: category_id,
            store_infos_value_eq: province_code
          })
        end
      end
      params[:q].except!(:province_code, :city_code)
      q = current_store_chain.stores.ransack(params[:q])
      @stores = q.result.order('id asc')
      respond_with @stores, location: nil
    end
  end
end
