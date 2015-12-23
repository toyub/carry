var vehicle_price_bar_chart = function(){
  require.config({
    paths: {
      echarts: '../../plugins/build/dist'
    }
  });

  require([
    "echarts",
    "echarts/chart/bar"
  ], function(ec){
    var vehiclePriceBarchart = ec.init(document.getElementById("price"),e_macarons);

    var priceOption = {

      tooltip:{
        trigger:"axis"
      },

      toolbox:{
        show: true,
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

      xAxis:{
        name : "车辆价值",
        type : "category",
        data : ["8-10万","10-15万","15-20万","20-35万","30-40万","40-50万","50-60万","60-70万","70-80万","80-90万","90-150万","150万以上"],
        splitLine:{show: false}
      },

      yAxis : {
        name :"消费金额",
        type : "value",
        splitLine:{show: false}
      },

      grid:{
        y:50,
        y2:30,
        x:60,
        x2:60,
        borderColor:"#fff"
      },

      series:[
        {
          type:"bar",
          name:"数量",
          data : [20,60,80,90,100,40,60,70,80,150,60,10],
          itemStyle : { normal: {label : {show: true,formatter : "{c} 辆", textStyle:{ color: "#656565",fontSize:"12"}}}},
          markPoint:{
            data : [{ type: "max"}]
          },
          barMinHeight : 20
        },
        {
          type:"bar",
          name:"价格",
          data : [2000,6000,8000,9000,10000,4000,6000,7000,8000,15000,6000,1000],
          itemStyle : { normal: {label : {show: true,formatter : "{c} 元",textStyle:{ color: "#656565",fontSize:"12"}}}},
          markPoint:{
            data : [{ type: "max"}]
          }
        }
      ]
    }

    vehiclePriceBarchart.setOption(priceOption);
  });
}
