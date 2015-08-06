class Ajax::GeosController < Ajax::BaseController
  def show
    respond_with Geo.countries
  end

  def states
    respond_with Geo.countries
  end
end
