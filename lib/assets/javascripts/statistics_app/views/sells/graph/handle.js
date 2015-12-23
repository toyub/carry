jQuery(function($){

  var bar_chart_section = function(){
    require.config({
      paths: {
        echarts: '../../plugins/build/dist'
      }
    });

    require([
      "echarts",
      "echarts/chart/bar"
    ],
    function(ec){

      var yearOnYearBarchart = ec.init(document.getElementById("year_on_year_barchart"));

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

    }); // end of yearOnYearBarchart in require function

    require([
      "echarts",
      "echarts/chart/bar"
    ],
    function(ec) {
      var halfYearBarchart = ec.init(document.getElementById("half_year_barchart"));

      var halfYearBarchartOption = {
        tooltip:{
          show:true
        },

        xAxis:[
          {
            type:"category",
            show: true,
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

            "data":[50000,43000,61000,34000,71000,69000,9000]
          }
        ]
      };
      halfYearBarchart.setOption(halfYearBarchartOption);
    }); // end of halfYearBarchart in require function
  }  // the end of bar_chart_section definition

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

  var line_char_section = function(){
    require.config({
      paths: {
        echarts: 'http://echarts.baidu.com/build/dist'
      }
    });

    require([
      "echarts",
      "echarts/chart/line"
    ],
    function(ec) {
      var lineChart = ec.init(document.getElementById("linchart"));

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
    });
  }  // the end of line_chart_section definition

  bar_chart_section();
  pie_char_section();
  line_char_section();
});
