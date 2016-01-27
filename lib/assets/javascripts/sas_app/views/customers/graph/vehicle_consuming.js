var vehicle_price_consuming_bar = function(data){
    var vehiclePriceBarchart = echarts.init(document.getElementById("price"),e_macarons);

		var priceOption = {
			tooltip : {
				trigger: 'axis'
			},
			toolbox: {
				show : true,
				feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType: {show: true, type: ['line', 'bar']},
					restore : {show: true},
					saveAsImage : {show: true}
				}
			},
			calculable : true,
			legend: {
				data:['消费金额','消费汽车数量']
			},
			xAxis : [
			{
        name: "车辆价值",
				type : 'category',
				data : ['8万一下','8-10万','10-15万','15-20万','20-30万','30-40万','40-60万','60-80万','80-100万','100万以上']
			}
			],
			yAxis : [
			{
				type : 'value',
				name : '消费金额',
				min: 0,
				max: 200000,
				interval: 20000,
				axisLabel : {
					formatter: '{value} 元'
				}
			},
			{
				type : 'value',
				name : '车辆总数',
				min: 0,
				max: 60,
				interval: 10,
				axisLabel : {
					formatter: '{value} 辆'
				}
			}
			],
			series : [

			{
				name:'消费金额',
				type:'bar',
				data: data.vehicle_amount,
			},
			{
				name:'消费汽车数量',
				type:'line',
				yAxisIndex: 1,
				data: data.vehicle_quantity
			}
			]
		};

		vehiclePriceBarchart.setOption(priceOption);
}
