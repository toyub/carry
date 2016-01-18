var year_sales_bar_chart = function(data){

    var halfYearBarchart = echarts.init(document.getElementById("half_year_barchart"));

    var halfYearBarchartOption = {
      tooltip:{
        show:true
      },

      xAxis:[
        {
          type:"category",
          show: true,
          data: data.months,
          axisLine:{
            show:false
          },
          axisTick:{
            show:false
          }
        }
      ],

      yAxis:[
        {
          type: "value",
          splitNumber:8
        }
      ],

      grid:{
        x : 50,
        x2 : 50,
        y : 20,
        y2 : 50
      },

      series:[
        {
          "type":"bar",

          itemStyle:{
            normal:{
              color: "#03c03c",
              label:{
                show: true,
                textStyle:{
                  color:"#000"
                }
              }
            }
          },

          "data": data.figures
        }
      ]
    }

    halfYearBarchart.setOption(halfYearBarchartOption);
}  // the end of bar_chart_section definition
