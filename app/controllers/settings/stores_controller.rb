class Settings::StoresController < Settings::BaseController
  include Uploadable

  def show
    @open_time = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '上班时间').where(using: true).first
    @close_time = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '下班时间').where(using: true).first
    
    

    @state = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '省份').where(using: true).first

    @city = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '城市').where(using: true).first
    @location = Geo.city(1, @state.value, @city.value)

    @address = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '详细地址').where(using: true).first
    @longi_and_lati = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '经纬度').where(using: true).first
    @contact_phone = current_store.store_infos.joins(:info_category).where('info_categories.name = :name', name: '联系电话').where(using: true).first
  end

  def edit

  end

  def update
  end

  private
  def resource
    @store ||= current_store
  end
end
