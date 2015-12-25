var month_sales_pie_chart = function() {

  var salesPieChart = echarts.init(document.getElementById("sales_piechart"));

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
  }
  salesPieChart.setOption(salesPieChartOption);
}  // the end of bar_chart_section definition
