var month_consume_chart = function(){
    var lineChart = echarts.init(document.getElementById("linchart"));

    var month = [];

    for(var i = 1; i<= 31; i++){
      month.push(i);
    };


    var lineChartOption = {
      toolbox:{
        show:true
      },

      xAxis:[
        {
          type:'category',
          data: month,
          splitLine:{
            show:false
          },
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
          type: 'value',
          axisLine:{
            show:false
          },
          axisTick:{
            show:false
          }
        }
      ],

      grid:{
        x : 50,
        x2 : 0,
        y : 30,
        y3: 30
      },

      series:[
        {
          type:'line',

          symbol:"circle",

          data:[1000,1200,1300,1400,1500,1600,1700,1800,1900,1950,1960,1980,1990,2000,2100,2150,2200,2300,2350,2400,2450,2500,2550,2600,2650,2786],

          itemStyle:{
            normal:{
              color:"#EF55B4",
              label:{
                show:false
              }
            },
            emphasis:{
              label:{
                show:true,
                formatter:"商品销售\n金额\t{c}",
                textStyle:{
                  color:"#000",
                  fontSize: 15
                }
              }
            }
          }
        },
        {
          type:'line',

          symbol:"circle",

          data:[1500,1550,1560,1580,1590,1530,1310,1060,950,900,800,780,800,890,1180,1300,1400,1500,1600,1700,1800,2000,2200,2300,2400,2500,2600],

          itemStyle:{
            normal:{
              color:"#EA673A"
            },
            emphasis:{
              label:{
                show:true,
                formatter:"服务销售\n金额\t{c}",
                textStyle:{
                  color:"#000",
                  fontSize: 15
                }
              }
            }
          }
        },
        {
          type:'line',

          symbol:"circle",

          data:[520,500,510,520,530,540,580,600,700,800,1000,1250,1140,1100,1000,900,800,600,550,580,680,880,1080,1180,1240],

          itemStyle:{
            normal:{
              color:"#9384EA"
            },
            emphasis:{
              label:{
                show:true,
                formatter:"套餐销售\n金额\t{c}",
                textStyle:{
                  color:"#000",
                  fontSize: 15
                }
              }
            }
          }
        }
      ]
    };

    lineChart.setOption(lineChartOption);
}  // the end of line_chart_section definition
