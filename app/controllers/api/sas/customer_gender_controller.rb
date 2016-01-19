class Api::Sas::CustomerGenderController < Api::BaseController
  def index
    render json: Sas::CustomerGenderCategories.new(current_store)
  end
end
