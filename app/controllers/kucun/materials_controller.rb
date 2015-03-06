class Kucun::MaterialsController < Kucun::ControllerBase
  def index
    
  end

  def new
    @store_material = StoreMaterial.new
  end

  def create
    render json:params
  end

  def autocomplete_name
    result = [params[:q], 'a1', 'a2', 'a3']
    render text: "#{params[:callback]}(#{result.to_json})"
  end
end