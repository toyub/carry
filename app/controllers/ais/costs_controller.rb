class Ais::CostsController < Ais::BaseController
  def index
    @materials = StoreMaterial.all
  end

  def search
    @world = "hello"
    render "index"
  end
end
