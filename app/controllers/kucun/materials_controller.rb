class Kucun::MaterialsController < Kucun::ControllerBase
  def index
    
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
    @store_material = StoreMaterial.new
    @store_material.id=2
  end

  def saleinfo
    @store_material = StoreMaterial.new
    @store_material.id=2
  end

  def commission
    @store_material = StoreMaterial.new
    @store_material.id=2
  end

  def tracing
    @store_material = StoreMaterial.new
    @store_material.id=2
  end

  def autocomplete_name
    result = [params[:q], 'a1', 'a2', 'a3']
    render text: "#{params[:callback]}(#{result.to_json})"
  end

  def save_picture
    unless Rails.root.join('public', 'attachments', 'materials', '2', 'images').exist?
      FileUtils.mkdir_p Rails.root.join('public', 'attachments', 'materials', '2', 'images')
    end
    file_name="p#{Time.now.to_f}.png"
    file_path = Rails.root.join('public', 'attachments', 'materials', '2', 'images', file_name).to_path
    data = Base64.decode64(params[:img].gsub('data:image/png;base64,', ''))
    p data
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
end
