class Kucun::MaterialsController < Kucun::ControllerBase

  before_filter :set_material, only: [:show, :edit]

  def index
    @store = current_store
    @store_materials = @store.store_materials
    respond_to do |format|
      format.json {
        render json: @store_materials.to_json
      }

      format.html {}
    end
  end

  def new
    @store = current_user.store
    @store_material = @store.store_materials.new
  end

  def create
    x = StoreMaterial.new(material_params)

    x.store_id=current_user.store_id
    x.store_chain_id=current_user.store_chain_id
    x.store_staff_id=current_user.id
    x.save

    render json: x
  end

  def edit

  end

  def update
    render json: params
  end

  def show
  end

  def autocomplete_name
    result = StoreMaterial.where('name like :name', name: "%#{params[:q]}%").map(&:name)

    render text: "#{params[:callback]}(#{result.to_json})"
  end

  def save_picture
    @material = StoreMaterial.find(params[:id])
    @material.uploads.create(img_params)
    render text: :ok
  end

  private
  def material_params
    params.require(:material).permit(:store_material_root_category_id, :store_material_category_id, :store_material_unit_id,
                                     :store_material_manufacturer_id, :store_material_brand_id,
                                     :name, :speci, :barcode, :mnemonic,
                                     :min_price, :cost_price,
                                     :inventory_alarmify, :max_inventory, :min_inventory,
                                     :expiry_alarmify, :shelf_life, :permitted_to_internal,
                                     :permitted_to_saleable, :remark)
  end

  def img_params
    params.permit(:img).merge(store_staff_id: current_staff.id, store_id: current_store.id)
  end

  def set_material
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:id])
  end
end
