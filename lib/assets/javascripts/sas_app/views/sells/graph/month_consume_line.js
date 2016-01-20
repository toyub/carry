var month_sales_line_chart = function(data){
    var lineChart = echarts.init(document.getElementById("linchart"));

    var lineChartOption = {
      toolbox:{
        show:true
      },
      legend: {
        data: ['商品消费', '服务消费', '套餐消费'],
      },
      xAxis:[
        {
          type:'category',
          boundaryGap: false,
          data: data.days,
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
          name: '商品消费',
          type:'line',

          symbol:"circle",

          data:  data.materials,

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
          name: '服务消费',
          type:'line',

          symbol:"circle",

          data: data.services,

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
          name: '套餐消费',
          type:'line',

          symbol:"circle",

          data: data.packages,

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
