class Settings::DepotsController < Settings::BaseController
  def index
    @store = current_store
  end

  def fetch
    @store = current_store
    @depots = @store.store_depots
    render json: @depots, root: nil
  end

  def create
    render json: depot_params.merge(id: Time.now.to_i)
  end

  def update
    render json: depot_params
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
    params.require(:depot).permit(:id, :name, :description, :admins,
                                                            :created_at,
                                                            :creator,
                                                            :deleted,
                                                            :preferred,
                                                            :useable)
  end
end