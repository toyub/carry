module Api
  class StoreStatisticsController < BaseController

    def annual_sales
      @data = {
        months: ["3月份","4月份","5月份","6月份","7月份","18月份","9月份"],
        figures: [50000,43000,61000,34000,71000,69000,19000],
      }
      render json: @data
    end

  end
end
