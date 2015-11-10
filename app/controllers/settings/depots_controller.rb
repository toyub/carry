class Settings::DepotsController < Settings::BaseController
  def index
    @store = current_store
    @depots = @store.store_depots
  end
end