class Ais::IncomesController < Ais::BaseController
  def index
  end

  def search
    @hello = "world"
    render "index"
  end
end
