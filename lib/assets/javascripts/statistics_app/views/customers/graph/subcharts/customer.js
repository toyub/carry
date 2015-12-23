var customer_bar_chart = function(){
  require.config({
    paths: {
      echarts: '../../plugins/build/dist'
    }
  });

  require([
    "echarts",
    "echarts/chart/bar"
  ], function(ec){

    var customerBarchart = ec.init(document.getElementById("customers_barchart"),e_macarons);

    var customerOption = {

      tooltip : {
        trigger: 'axis',
        axisPointer : {
          type : 'shadow'
        }
      },

      legend: {
        data:['女性','男性']
      },

      toolbox: {
        show : true,
        feature : {
          magicType :{
            show : true,
            type : ["line","bar","stack","tiled"]
          },

          restore:{
            show: true,
            title : "还原"
          },

          saveAsImage : {show: true, title: "保存为图片",type: "png", lang:["点击保存"]}
        }
      },

      calculable: true,

      xAxis : [
        {
          type : 'value',
          splitLine:false,
          axisTick:{show: true}
        }
      ],

      yAxis : [
        {
          type : 'category',
          data : ['会员客户','非会员客户','集团客户'],
          splitLine:false
        }
      ],
      grid:{
        y:35,
        y2:35,
        width:680,
        borderColor:"#fff"
      },

      series : [
        {
          name:'女性',
          type:'bar',
          stack: '总量',
          itemStyle : {
            normal: {
              label : {
                show: true,
                position: 'insideRight'
              },
              barBorderRadius:5,
              barBorderWidth:5
            },
            emphasis:{
              label : {
                show: true,
                position: 'insideRight'
              },
              barBorderRadius:5,
              barBorderWidth:5
            }
          },
          data:[120, 132, 101],
          barCategoryGap:"35%"
        },

        {
          name:'男性',
          type:'bar',
          stack: '总量',
          itemStyle : {
            normal: {
              label : {
                show: true,
                position: 'insideRight'
              },
              barBorderRadius:5,
              barBorderWidth:5
            },
            emphasis:{
              label : {
                show: true,
                position: 'insideRight'
              },
              barBorderRadius:5,
              barBorderWidth:5
            }
          },
          data:[220, 182, 191]
        }
      ]
    };

    customerBarchart.setOption(customerOption);
  });
}
