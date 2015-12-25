var payment_ways_pie_chart = function(data){
  var paymentPieChart = echarts.init(document.getElementById("payment_piechart"));

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

        data: [
          {value:70,name:'现金'},
          {value:10,name:'刷卡'},
          {value:10,name:'支付宝'},
          {value:10,name:'微信支付'}
        ],
      }
    ]
  }

  paymentPieChart.setOption(paymentPieChartOption);
}
