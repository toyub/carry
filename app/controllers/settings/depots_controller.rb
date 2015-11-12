class Settings::DepotsController < Settings::BaseController
  before_action :set_store
  before_action :set_depot, only: [:toggle_useable, :prefer, :binding_material_count, :destroy, :update]

  def index
    @store_staff = @store.store_staff #loginable
  end

  def fetch
    @depots = @store.store_depots
    render json: @depots, root: nil
  end

  def create
    depot = @store.store_depots.new(depot_params)
    depot.save
    render json: depot, root: nil
  end

  def update
    @depot.update!(depot_params)
    render json: @depot, root: nil
  end

  def toggle_useable
    @depot.toggle_useable!
    render json: {text: 'ok'}
  end

  def prefer
    current_depot = @store.store_depots.current_preferred
    if current_depot.present?
      current_depot.update!(preferred: false)
    end
    @depot.update!(preferred: true)
    render json: {text: 'ok'}
  end

  def binding_material_count
    count = @depot.binding_material_count
    render json: {bound: count}
  end

  def destroy
    if @depot.useable
      render status: 409, json: {error: '不能删除正在使用的仓库!'}
    else
      @depot.update!(deleted: true)
      render json: {text: 'ok'}
    end
  end

  private
  def set_store
    @store = current_store
  end

  def set_depot
    @depot = @store.store_depots.find(params[:id])
  end

  def depot_params
    params.require(:depot).permit(:id, :name, :description, admin_ids: []).merge(store_staff_id: current_staff.id)
  end
end