var consuming_distribution_pie = function(data){
  var consuming_distribution_pie = echarts.init(document.getElementById("consuming_distribution_pie"));

  var pie_option = {
    title : {
      show : true,
      text : "客户消费金额构成",
      x : 160,
      textStyle :{
        color : "#8E8D8D",
        fontWeight : "normal"
      }
    },

    tooltip:{
      trigger : "item",
      formatter : "{a}<br>{b} : {c}人 ({d}%)"
    },

    toolbox:{
      show : true,
      x : 340,
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

    legend: {
      orient: "vertical",
           x: "left",
        data: ["8000-10000元","5000-8000元","3000-5000元","1000-3000元", "0-1000元"],
    },

    calculable : false,

    series:[
      {
        "name" : "消费构成",
        "type" : "pie",
        "radius" : "65%",
        "center" : ["50%","60%"],
        "data" : [
          {value:data[0],name:"0-1000元"},
          {value:data[1],name:"1000-3000元"},
          {value:data[2],name:"3000-5000元"},
          {value:data[3],name:"5000-8000元"},
          {value:data[4],name:"8000-10000元"},
        ]
      }
    ]
  }

  consuming_distribution_pie.setOption(pie_option);
}
