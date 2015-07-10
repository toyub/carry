class Xiaoshou::ServicesController < Xiaoshou::BaseController
  before_action :load_store

  def index
    @services = StoreService.of_store(@store.id)
  end

  private
  def load_store
    @store = current_user.store
  end
end
