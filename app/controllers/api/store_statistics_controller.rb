class Api::StoreStatisticsController < Api::BaseController

  ##################
  # api for sells  #
  ##################
  def annual_sales
    @data = {
      months: ["3月份","4月份","5月份","6月份","7月份","18月份","9月份"],
      figures: [50000,43000,61000,34000,71000,69000,19000],
    }
    render json: @data
  end

  def payment_ways
    @data = [
      {value:70,name:'现金'},
      {value:10,name:'刷卡'},
      {value:10,name:'支付宝'},
      {value:10,name:'微信支付'}
    ]
    render json: @data
  end

  def month_sales_pie
    @data = {
    }
    render json: @data
  end

  def month_sales_line
    @data = {
      months: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
                22, 23, 24, 25, 26, 27, 28, 29, 30],

      material: { figures: [1000,1200,1300,1400,1500,1600,1700,1800,1900,1950,1960,1980,
                            1990,2000,2100,2150,2200,2300,2350,2400,2450,2500,2550,2600,
                            2650,2786]
                },
      service: { figures: [1500,1550,1560,1580,1590,1530,1310,1060,950,900,800,
                           780,800,890,1180,1300,1400,1500,1600,1700,1800,2000,
                           2200,2300,2400,2500,2600]
               },
      package: { figures: [520,500,510,520,530,540,580,600,700,800,1000,1250,1140,1100,
                            800,600,550,580,680,880,1080,1180,1240]
               }
    }
    render json: @data
  end

  ######################
  # api for customers  #
  ######################
  def gender_proportion
    @data = {
      title: ['女性','男性'],
      content: { category: ['会员客户','非会员客户','集团客户'],
                 female: [120, 132, 101],
                 male: [220, 182, 191],
               }
    }
    render json: @data
  end

  def category_proportion
    @data = {
      title: ["集团消费","会员消费","非会员消费"],
    }
    render json: @data
  end

  def vehicle_price_proportion
    @data = {
      xAxis: {
        name: "车辆价值",
        type: "category",
        data: ["8-10万","10-15万","15-20万","20-35万","30-40万","40-50万",
               "50-60万","60-70万","70-80万","80-90万","90-150万","150万以上"],
        splitLine: {show: false},
      },
    }
    render json: @data
  end

  def vehicle_consuming_rank
    @data = {
      yAxis: { value: ["其他","奥迪","马自达","日产","本田","奔驰","宝马","丰田","大众"] },
    }
    render json: @data
  end

  def consuming_distribution
    @data = {
      legend: { orient: "vertical",
                     x: "left",
                  data: ["18000-10000元","5000-8000元","3000-5000元","1000-3000元","0-1000元"]
              }
    }
    render json: @data
  end

  def consuming_week
    @data = {
      legend: { data: ["0-1K元","1-3K元","3-5K元","5-8K元","8-10K元"],
                     x: 180,
              }
    }
    render json: @data
  end

end
