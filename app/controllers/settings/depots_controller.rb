class Settings::DepotsController < Settings::BaseController
  def index
    @store = current_store
    @store_staff = @store.store_staff #loginable
  end

  def fetch
    @store = current_store
    @depots = @store.store_depots
    render json: @depots, root: nil
  end

  def create
    store = current_store

    depot = store.store_depots.new(depot_params)

    render json: depot, root: nil
  end

  def update
    render json: depot_params, root: nil
  end

  def toggle_useable

  end

  def prefer

  end

  def binding_material_count
    render json: {bound: 12}
  end

  private
  def depot_params
    params.require(:depot).permit(:id, :name, :description, :admin_ids).merge(store_staff_id: current_staff.id)
  end
end