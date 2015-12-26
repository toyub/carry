class Api::Sas::CustomerGenderController < Api::BaseController
  def index
    @data = {
      female: [120, 132, 101],
      male: [220, 182, 191],
    }
    render json: @data
  end
end
