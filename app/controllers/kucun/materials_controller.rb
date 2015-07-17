class Kucun::MaterialsController < Kucun::ControllerBase

  before_filter :set_material, only: [:show, :edit]

  def index
    @store_materials = StoreMaterial.all
    respond_to do |format|
      format.json {
        render json: @store_materials
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
    material = StoreMaterial.find(params[:id])
    pic_path = Rails.root.join('public', 'attachments', 'materials', material.id.to_s, 'images')
    unless pic_path.exist?
      FileUtils.mkdir_p pic_path
    end
    file_name="p#{Time.now.to_f}.png"
    file_path = Rails.root.join(pic_path, file_name).to_path
    data = Base64.decode64(params[:img].gsub('data:image/png;base64,', ''))
    material.store_material_images.create(file_name: file_name, file_size: data.size, content_type: 'image/png')
    File.open(file_path, 'w') do |f|
      IO.binwrite f, data
    end
    render text: file_name

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

  def set_material
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:id])
  end
end
