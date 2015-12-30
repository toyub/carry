class Ais::CostsController < Ais::BaseController
  def index
  end

  def search
    @world = "hello"
    render "index"
  end
end
