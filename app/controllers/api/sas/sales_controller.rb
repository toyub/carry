class Api::Sas::SalesController < Api::BaseController
  def index
    @data = {
      title: ["集团消费","会员消费","非会员消费"],
    }
    render json: @data
  end
end
