class Settings::StoresController < Settings::BaseController
  def show
    @open_time = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '上班时间').first
    @close_time = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '下班时间').first
    @state = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '省份').first
    @city = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '城市').first
    @address = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '详细地址').first
    @longi_and_lati = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '经纬度').first
    @contact_phone = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '联系电话').first
  end

  def edit

  end

  def update
    render json: params
  end
end
