var payment_ways_pie_chart = function(data){
  var paymentPieChart = echarts.init(document.getElementById("payment_piechart"));

  var paymentPieChartOption = {

    legend: {
      data: ['现金', '银行卡', '支付宝', '微信支付']
    },
    series:[
      {
        type:'pie',
        radius:['50%','70%'],

        itemStyle:{
          normal:{
            color:function(params){
              var colorList = [
                "#483c32","#734f96","#ff8c00","#3980B5"
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

        data: data,
      }
    ]
  }

  paymentPieChart.setOption(paymentPieChartOption);
}
