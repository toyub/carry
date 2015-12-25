class Api::StoreSalesController < Api::BaseController
  def index
    @data = {
      title: ["集团消费","会员消费","非会员消费"],
    }
    respond_with @data, location: nil
  end
end
