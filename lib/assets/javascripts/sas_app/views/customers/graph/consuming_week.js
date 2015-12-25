var consuming_week_bar = function(data){
  var consuming_week_bar = echarts.init(document.getElementById("consuming_distribution_bar"));


  var bar_option = {

    tooltip:{
      show : true,
      formatter : "{b}<br> {a}：{c}人"
    },

    legend : data.legend,

    toolbox:{
      show : true,
      x : 600,
      feature : {
        mark : {
          show : true,
          title : {
            mark : "辅助线开关",
            markUndo : "删除辅助线",
            markClear : "清空辅助线"
          },
          lineStyle : {
            width :2,
            color : "red",
            type : "dashed"
          }
        },

        dataView : {
          show : true,
          title : "数据视图",
          readOnly : false,
          lang : ["数据视图", "关闭", "刷新"]
        },

        magicType : {
          show : true,
          title : {
            pie: '饼图切换',
            funnel: '漏斗图切换'
          },
          type : [ 'pie', 'funnel'],
          option: {
            funnel: {
              x: '25%',
              width: '50%',
              funnelAlign: 'left',
              max: 1548
            }
          }
        },

        restore : {
          show : true,
          title : "还原"
        },
        saveAsImage : {
          show : true,
          title : "保存为图片",
          type : "png",
          lang : ["点击保存"]
        }
      }
    },

    xAxis:{
      type : "category",
      data : ['周一','周二','周三','周四','周五','周六','周日'],
      splitLine : false
    },

    yAxis:{
      type : "value",
      axisLabel:{
        formatter: function(value){
          return value/1000 + "K";
        }
      },
      splitLine : false
    },

    grid:{
      x: 120,
      x2 : 100,
      y : 40,
      y2 : 30,
      borderColor : "#fff"
    },

    series:[
      {
        "name" : "0-1K元",
        "type" : "bar",
        "stack" : "总量",
        "data" : [1500,1600,1500,1600,1700,1800,1500]
      },
      {
        "name" : "1-3K元",
        "type" : "bar",
        "stack" : "总量",
        "data" : [900,1003,980,990,980,1120,1110]
      },
      {
        "name" : "3-5K元",
        "type" : "bar",
        "stack" : "总量",
        "data" : [1200,1150,1150,1220,1500,1450,1900]
      },
      {
        "name" : "5-8K元",
        "type" : "bar",
        "stack" : "总量",
        "data" : [1000,1100,1050,1050,1200,1300,1400]
      },
      {
        "name" : "8-10K元",
        "type" : "bar",
        "stack" : "总量",
        "data" : [2600,2700,2800,2900,3600,3600,4600]
      }
    ]
  };

  consuming_week_bar.setOption(bar_option);
}
