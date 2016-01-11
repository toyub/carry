var category_consuming_pie = function(data){
    var consumingPiechart = echarts.init(document.getElementById("consuming_piecharts"),e_macarons);

    var consumingOption = {

      tooltip:{
        trigger: "item",
        formatter:"{b} \n {c}"
      },

      legend:{
        data: ['集团消费', '会员消费'],
        x:70
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

      series:[
        {
          type: "pie",
          radius:[45,70],
          center:["20%","50%"],
          data:[
            {value:800,name:"集团消费",
              itemStyle:{
                normal:{
                  color: "#4A89DC",
                  label:{
                    formatter: "{b} \n {d}%",
                    textStyle:{
                      color: "#000",
                      fontSize: 12
                    }
                  }
                }
              }
            },
            {value:200,name:"其他",
              itemStyle:{
                normal:{
                  color: "#ccc",
                  label:{
                    show: false
                  }
                }
              }
            }
          ],
          itemStyle:{
            normal:{
              label:{ show: true, position: "center",
                textStyle:{
                  fontWeight: "bold"
                }
              },

              labelLine:{show:false}
            }
          }
        },

        {
          type: "pie",
          radius:[45,70],
          center:["50%","50%"],
          data:[
            {value:300,name:"非会员消费",
              itemStyle:{
                normal:{
                  color: "#3BAFDA",
                  label:{
                    formatter: "{b} \n {d}%",
                    textStyle:{
                      color: "#000",
                      fontSize: 12
                    }
                  }
                }
              }
            },
            {value:700,name:"其他",
              itemStyle:{
                normal:{
                  color: "#ccc",
                  label:{
                    show: false
                  }
                }
              }
            }
          ],
          itemStyle:{
            normal:{
              label:{ show: true, position: "center",
                textStyle:{
                  fontWeight: "bold"
                }
              },

              labelLine:{show:false}
            }
          }
        },

        {
          type: "pie",
          radius:[45,70],
          center:["80%","50%"],
          data:[
            {value:550,name:"会员消费",
              itemStyle:{
                normal:{
                  color:"#F6BB42",
                  label:{
                    formatter: "{b} \n {d}%",
                    textStyle:{
                      color: "#000",
                      fontSize: 12
                    }
                  }
                }
              }
            },
            {value:450,name:"其他",
              itemStyle:{
                normal:{
                  color: "#ccc",
                  label:{
                    show: false
                  }
                }
              }
            }
          ],
          itemStyle:{
            normal:{
              label:{ show: true, position: "center",
                textStyle:{
                  fontWeight: "bold"
                }
              },

              labelLine:{show:false}
            }
          }
        }
      ]
    }
    consumingPiechart.setOption(consumingOption);
}
