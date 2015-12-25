class Api::StoreCustomerGenderController < Api::BaseController
  def index
    @data = {
      title: ['女性','男性'],
      content: { category: ['会员客户','非会员客户','集团客户'],
                 female: [120, 132, 101],
                 male: [220, 182, 191],
               }
    }
    respond_with @data, location: nil
  end
end
