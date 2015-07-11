class Xiaoshou::ServicesController < Xiaoshou::BaseController
  before_action :load_store

  def index
    @services = @store.store_services
  end

  def new
    @services = @store.store_services
    @service = @store.store_services.new
  end

  private
  def load_store
    @store = current_user.store
  end
end
