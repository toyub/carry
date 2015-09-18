class Kucun::OutingsController < Kucun::ControllerBase
  def new
    @store = current_store
  end

  def create
    outing = StoreMaterialOuting.new(outing_params)
    render json: {outing: outing, items: outing.items}
  end

  private
  def outing_params
    params.require(:outing).permit(:requester_id, :outing_type_id, :remark, 
                                    items_attributes: [:store_material_id, :quantity,
                                                       :remark, :store_material_inventory_id, :store_depot_id])
  end
end
