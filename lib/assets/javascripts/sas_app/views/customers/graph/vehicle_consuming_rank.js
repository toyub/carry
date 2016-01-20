var vehicle_consuming_rank_bar = function(data){
    var vehicleRankBarchart = echarts.init(document.getElementById("rank"),e_macarons);

    var rankOption = {

      tooltip:{
        trigger:"axis",
        axisPointer:{
          type:"none"
        }
      },

      toolbox:{
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

      yAxis:{
        show: false,
        type : "category",
        data : data.brands
      },

      xAxis:{
        show : false,
        type : "value"
      },

      grid:{
        y:35,
        y2:10,
        x:0,
        x2:40,
        borderColor:"#fff"
      },

      series:[
        {
          type:"bar",
          name:"数量",
          data : data.number,
          barCategoryGap: "35%",

          itemStyle:{
            normal:{
              label: { show: true, formatter: "{b} \t {c}", textStyle:{ color:"#656565"}},
              color: function(params){
                var colorList = ["#F2E044","#E39956","#FC7F94","#D664A2","#CA69D5","#8A5FD1","#5659CD","#3B8DDA","#3BAFDA"];
                return colorList[params.dataIndex]
              }
            }
          }
        }
      ]
    }

    vehicleRankBarchart.setOption(rankOption);
}
