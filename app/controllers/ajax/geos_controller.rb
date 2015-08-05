class Ajax::GeosController < Ajax::BaseController
  def show
    Geo.countries
  end
end
