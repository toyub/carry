class Kucun::MaterialsController < Kucun::ControllerBase

  before_filter :set_material, only: [:show, :saleinfo, :commission, :tracing]

  def index
    @store_materials = StoreMaterial.all
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

  def update
    render json: params
  end

  def show
  end

  def saleinfo
  end

  def commission
  end

  def tracing
  end

  def autocomplete_name
    result = [params[:q], 'a1', 'a2', 'a3']
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
    params.require(:material).permit(:store_material_category_id, :store_material_unit_id, :store_material_manufacturer_id,
      :store_material_brand_id, :speci, :name, :barcode, :min_retail_price, :mnemonic, :cost_price, :retail_price, :remark)
  end

  def set_material
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:id])
  end
end
