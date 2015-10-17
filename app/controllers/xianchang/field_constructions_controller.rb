module Xianchang
  class FieldConstructionsController < BaseController
    def index
      if params[:type] == "profession"
        return render :professional_page
      end
    end
  end
end
