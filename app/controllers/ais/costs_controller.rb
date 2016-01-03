class Ais::CostsController < Ais::BaseController
  def index
    @material = StoreMaterial.first
    @intial_income = @material.initial_income
    @current_income = @material.current_income
    @current_outgo = @material.current_outgo
  end

  def search
    @world = "hello"
    render "index"
  end
end
