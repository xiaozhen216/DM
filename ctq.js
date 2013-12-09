
	var serviceUrlCTQ = "../display/json/199";
	
	function queryCTQ() {

		var selectedDate = $$("selectedDate").value;

		Ajax({
			url : serviceUrlCTQ,
			method : "POST",
			params : {"param1": selectedDate,"param2": selectedDate}, 
			type : "json",
			waiting : true,
			ondata : function() {
				var data = eval(this.getResponseText());
				show(data);
			}
		});	  
	}



	function showCTQ(originData) {
		var total = 0;
		var data = [];
		var maxdata=0;
		var scaledata=0;
		var spacedata = 0;
		for(var i = 0; i < originData.length; i++) {
			var weight = originData[i]["重量"];
			var province = originData[i]["分拨"];
			if (maxdata<weight) {
				maxdata=weight
			}
			scaledata=Math.round(maxdata/10000) * 10000 + 10000;
			spacedata = scaledata/5;
			total += weight;
			data[i] = {name: province, value: weight, color: '#c52120' };
		}
		
		total = Math.round(total/1000);

		$(function() {
				
				var chart = new iChart.Column2D({
						render : 'canvasDiv',
						data : data,
						title:{
							text:'各分拨货量',
							color:'#4572a7',
							textAlign:'left',
							padding:'0 40',
							border:{
							enable:true,
							width:[0,0,4,0],
							color:'#4572a7'
						},
						height:40
						},
						footnote : {
							text : '当日总货量： ' + total + ' T',
							height:30,
							color:'#c52120',
							fontweight : 600,
							padding : '0 40'
						},
						width : 1700,
						height : 750,
						padding:0,
						label : {
							fontsize:18,
							fontweight:600,
							color : '#666666'
						},
						shadow : true,
						shadow_blur : 2,
						shadow_color : '#aaaaaa',
						shadow_offsetx : 1,
						shadow_offsety : 0,
						background_color : '#f7f7f7',
						column_width : 62,
						sub_option : {
							label : {
								fontsize:12,
								fontweight:500,
								color : '#4572a7'
							},
							border : {
								width : 2,
								radius : '5 5 0 0',//上圆角设置
								color : '#ffffff'
							}
						},
						coordinate : {
							background_color : null,
							grid_color : '#c0c0c0',
							width : 1700,
							height:750,
						axis : {
							color : '#c0d0e0',
							width : [0, 0, 1, 0]
						},
						scale : [{
							position : 'left',
							start_scale : 0,
							end_scale : scaledata,
							scale_space : spacedata,
							scale_enable : false,
							label : {
							fontsize:15,
							fontweight:600,
							color : '#666666'
							}
						}]
					}
				});
				//利用自定义组件构造左侧说明文本
				chart.plugin(new iChart.Custom({
				drawFn:function(){
				//计算位置
				var coo = chart.getCoordinate(),
				x = coo.get('originx'),
				y = coo.get('originy');
				//在左上侧的位置，渲染一个单位的文字
				chart.target.textAlign('start')
					.textBaseline('bottom')
					.textFont('600 16px Verdana')
					.fillText('日期：' ,x-20,y-30,false,'#34a1d9')
					.textFont('600 11px Verdana')
					.fillText('单位：千克',x-20,y-10,false,'#34a1d9');
				}
				}));
				chart.draw();
				});

}	