class Ajax::GeosController < Ajax::BaseController
  def show
    respond_with Geo.countries
  end

  def states
    respond_with Geo.states(params[:country_code].to_s)
  end

  def cities
    respond_with Geo.cities(params[:country_code], params[:state_code])
  end
end
