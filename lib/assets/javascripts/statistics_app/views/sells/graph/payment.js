var pie_char_section = function(){
  require.config({
    paths: {
      echarts: 'http://echarts.baidu.com/build/dist'
    }
  });

  require([
    "echarts",
    "echarts/chart/pie"
  ],
  function(ec) {
    var paymentPieChart = ec.init(document.getElementById("payment_piechart"));

    var paymentPieChartOption = {

      series:[
        {
          type:'pie',
          radius:['50%','70%'],

          itemStyle:{
            normal:{
              color:function(params){
                var colorList = [
                  "#095086","#95BBD7","#679DC6","#3980B5"
                ];
                return colorList[params.dataIndex];
              },

              label:{
                show:false
              },

              labelLine:{
                show:false
              }
            },

            emphasis : {
              label : {
                show : true,
                position : 'center',
                formatter:'{b}\n {d}%',
                textStyle : {
                  fontSize : '25',
                  fontWeight : 'bold'
                }
              }
            }
          },

          data:[
            {value:70,name:'现金'},
            {value:10,name:'刷卡'},
            {value:10,name:'支付宝'},
            {value:10,name:'微信支付'}
          ]
        }
      ]
    };

    paymentPieChart.setOption(paymentPieChartOption);
  });  // end of paymentPieChart

  require([
    "echarts",
    "echarts/chart/pie"
  ],
  function(ec) {
    var salesPieChart = ec.init(document.getElementById("sales_piechart"));

    var salesPieChartOption = {
      series:[
        {
          type:'pie',
          radius:['50%','70%'],

          itemStyle:{
            normal:{
              color:function(params){
                var colorList = [
                  '#54728C','#90C657','#E45857','#F8A94A','#54B5DF'
                ];
                return colorList[params.dataIndex];
              },

              label:{
                show:false
              },
              labelLine:{
                show:false
              }
            },

            emphasis:{
              label:{
                show:true,
                position:'center',
                formatter:"{b}\n{d}%",
                textStyle:{
                  fontSize:'25',
                  fontWeight: 'bold'
                }
              }
            }
          },

          data:[
            {value:60,name:'商品销售'},
            {value:15,name:'服务销售'},
            {value:5,name:'套餐销售'},
            {value:10,name:'其他销售'},
            {value:10,name:'其他2销售'}
          ]
        }
      ]
    };

    salesPieChart.setOption(salesPieChartOption);
  }); // end of salesPieChart
}  // the end of bar_chart_section definition
