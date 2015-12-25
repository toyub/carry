var year_sales_bar_chart = function(sales){

    var yearOnYearBarchart = echarts.init(document.getElementById("year_on_year_barchart"));

    var yearOnYearBarchartOption = {
      tooltip:{
        show: true
      },

      grid:{
        x : 50,
        x2 : 50,
        y : 20,
        y2 : 50
      },

      xAxis:[
        {
          type: "category",
          data:["3月份","4月份","5月份","6月份","7月份","8月份","9月份"],
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

      series:[
        {
          "type": "bar",
          barWidth: 34,
          barCategoryGap:12,

          itemStyle:{
            normal:{
              color:function(params){
                var colorList = [
                  "rgba(166,192,226,0.8)","rgba(180,166,226,0.8)","rgba(166,226,224,0.8)","rgba(166,226,183,0.8)","rgba(226,207,166,0.8)","rgba(172,168,160,0.8)","rgba(172,168,160,0.8)"
                ];
                return colorList[params.dataIndex]
              },

              label:{
                show: true,
                textStyle:{
                  color:"#000",
                  fontSize:11
                }
              }
            }
          },

          "data":[50000,43000,61000,34000,71000,69000,9000]
        },
        {
          "type": "bar",
          barWidth: 34,
          barCategoryGap:12,

          itemStyle:{
            normal:{
              color:"#426A9F",

              label:{
                show: true,
                formatter: "{c}\n\n\n2014",
                position:"inside",
                textStyle:{
                  color:"#fff",
                  fontSize:11
                }
              }
            }
          },

          "data":[41000,27000,52000,45000,25000,25000,25000]
        }
      ]
    }

    yearOnYearBarchart.setOption(yearOnYearBarchartOption);

    var halfYearBarchart = echarts.init(document.getElementById("half_year_barchart"));

    var halfYearBarchartOption = {
      tooltip:{
        show:true
      },

      xAxis:[
        {
          type:"category",
          show: true,
          data: sales.months,
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
              color:function(params){
                var colorList = [
                  "rgba(166,192,226,0.8)","rgba(180,166,226,0.8)","rgba(166,226,224,0.8)","rgba(166,226,183,0.8)","rgba(226,207,166,0.8)","rgba(172,168,160,0.8)","rgba(172,168,160,0.8)"
                ];
                return colorList[params.dataIndex]
              },
              label:{
                show: true,
                textStyle:{
                  color:"#000"
                }
              }
            }
          },

          "data": sales.figures
        }
      ]
    }

    halfYearBarchart.setOption(halfYearBarchartOption);
}  // the end of bar_chart_section definition
