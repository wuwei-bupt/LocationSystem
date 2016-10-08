<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path +"/";

%>
<html>
<head>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<style type="text/css">
	#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=${baidu_map_api_account}"></script>

<script type="text/javascript">
	$(function() {
		// 百度地图API功能
		var map = new BMap.Map("allmap");    // 创建Map实例
		var point = new BMap.Point(116.417, 35.909);
		map.centerAndZoom(point, 5);  // 初始化地图,设置中心点坐标和地图级别
		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	  	
		map.addControl(new BMap.NavigationControl());        // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl());             // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl());       //添加缩略地图控件
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		
       var farmerMarkers = [];
       var factoryMarkers = [];
       var depotMarkers = [];
       var fieldMarkers = [];
       function showFarmer(from, to){
       		$.ajax({
				async : true,
				type : "POST",
				url : "getFootprintFarmerInfo",
				dataType : "json",
				data: 'from='+from+'&to='+to,
				success : function(result) {
					//map.clearOverlays(); 	// 清空所有的覆盖物
					var convertor = new BMap.Convertor();
					$.each(result, function(key, item){
						if(item.longitude != null && item.latitude != null){
							var pointArr = [];
							var lng = item.longitude;
							var lat = item.latitude;
							var point = new BMap.Point(lng,lat);
							pointArr.push(point);
							
							convertor.translate(pointArr, 1, 5, function(data){
								if(data.status == 0){
									//for(var i=0;i<data.points.length;i++){
										var marker = new BMap.Marker(data.points[0]);
										farmerMarkers.push(marker);
										map.addOverlay(marker);
										
										var mytitle = "";
										marker.addEventListener('click', function(){
											mytitle = "<p style='margin-top:5xp;'>农户编号：" +item.smFarmer + "&nbsp;户主名：" + item.nameFamer + "&nbsp;地址：" + item.address + "</p>";
											var opts = {
												width:500,
												height:450,
												title: mytitle
											};
											
											var content = "";
											var pageNumber = 1;  // 第几页
											//var total = result.total; // 总的记录数
											var totalPages = 1; // 总的页面数
											var pageSize = 1;
											var infoWindow;
											var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
															+ "<caption align='top' style='font-weight:bold;'>农户采集记录</caption>"
															+"<thead><tr><th>记录编码</th><th>采集者</th><th>手机</th><th>公司</th><th>粮食名称</th></tr></thead>";
											var table_tail = "</table>";
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootprintFarmerRecords?smFarmer=" + item.smFarmer + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
												dataType : "json",
												success : function(result) {
													totalPages = result.totalPages;
													pageSize = result.pageSize;
													pageNumber = result.pageNumber;
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														records += "<tr><td>" + itemRecord.smCollection + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
																	+ "<td>" + itemRecord.grainname + "</td></tr>";
													});
													//console.log(content);
													if(pageNumber>1){
														mypage += "<p style='text-align:right;'><a class='tt' href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(pageNumber != 0){
														mypage += "第" + pageNumber +  "/" + totalPages + "页";
													}
													if(pageNumber<totalPages){
														mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
													}
													mypage += "</p>";
													content = table_head + records + table_tail + mypage;
													infoWindow = new BMap.InfoWindow(content, opts);
												}
											});
											
											// 下一页
											pageUp = function(){
												if(pageNumber < totalPages){
													pageNumber++;
													$.ajax({
														async : false,// 取消异步请求
														type : "POST",
														url : "getFootprintFarmerRecords?smFarmer=" + item.smFarmer + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
														dataType : "json",
														success : function(result) {
															content = '';
															pageNumber = result.pageNumber;
															var records = "";
															var mypage = "<p style='text-align:right;'>";
															$.each(result.rows, function(keyRecord, itemRecord){
																records += "<tr><td>" + itemRecord.smCollection + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
																	+ "<td>" + itemRecord.grainname + "</td></tr>";
															});
															//console.log(content);
															if(pageNumber>1){
																mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
															}
															if(pageNumber != 0){
																mypage += "第" + pageNumber + "/" + totalPages + "页";
															}
															if(pageNumber<totalPages){
																mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
															}
															mypage += "</p>"
															content = table_head + records + table_tail + mypage;
															infoWindow.setContent(content);
														}
													});
												}else{
													alert('已到最后一页！');
												}
											}
											// 上一页
											pageDown = function(){
												if(pageNumber > 1){
													pageNumber--;
													$.ajax({
														async : false,// 取消异步请求
														type : "POST",
														url : "getFootprintFarmerRecords?smFarmer=" + item.smFarmer + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
														dataType : "json",
														success : function(result) {
															content = '';
															var records = "";
															var mypage = "<p style='text-align:right;'>";
															pageNumber = result.pageNumber;
															$.each(result.rows, function(keyRecord, itemRecord){
																records += "<tr><td>" + itemRecord.smCollection + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
																	+ "<td>" + itemRecord.grainname + "</td></tr>";
															});
															if(pageNumber>1){
																mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
															}
															if(pageNumber != 0){
																mypage += "第" + pageNumber + "/" + totalPages + "页";
															}
															if(pageNumber<totalPages){
																mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
															}
															mypage += "</p>";
															content = table_head + records + table_tail + mypage;
															infoWindow.setContent(content);
														}
													});
												}else{
													alert('已到第一页！');
												}
											}
											map.openInfoWindow(infoWindow, data.points[0]);
											
										});
									//}
								}
							});
						}
					});
				}
			});
       }
       
       function showFactory(from, to){
       		$.ajax({
				async : true,// 取消异步请求
				type : "POST",
				url : "getFootprintFactoryInfo",
				dataType : "json",
				data: 'from='+from+'&to='+to,
				success : function(result) {
					//map.clearOverlays(); 	// 清空所有的覆盖物
					var overlays = map.getOverlays();
					var convertor = new BMap.Convertor();
					$.each(result, function(key, item){
						if(item.longitude != null && item.latitude != null){
							var pointArr = [];
							var lng = item.longitude;
							var lat = item.latitude;
							var point = new BMap.Point(lng,lat);
							pointArr.push(point);
							
							convertor.translate(pointArr, 1, 5, function(data){
								if(data.status == 0){
									//for(var i=0;i<data.points.length;i++){
										
										var marker = new BMap.Marker(data.points[0]);
										factoryMarkers.push(marker);
										map.addOverlay(marker);
										
										var mytitle = "";
										marker.addEventListener('click', function(){
											mytitle = "<p style='margin-top:5xp;'>加工厂编号：" +item.smFactory + "&nbsp;加工厂名称：" + item.nameFactory + "&nbsp;地址：" + item.address + "</p>";
											var opts = {
												width:500,
												height:450,
												title: mytitle
											};
											
											var content = "";
											var pageNumber = 1;  // 第几页
											//var total = result.total; // 总的记录数
											var totalPages = 1; // 总的页面数
											var pageSize = 1;
											var infoWindow;
											var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
															+ "<caption align='top' style='font-weight:bold;'>加工厂采集记录</caption>"
															+"<thead><tr><th>记录编码</th><th>采集者</th><th>手机</th><th>公司</th><th>粮食名称</th></tr></thead>";
											var table_tail = "</table>";
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootprintFactoryRecords?smFactory=" + item.smFactory + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
												dataType : "json",
												success : function(result) {
													totalPages = result.totalPages;
													pageSize = result.pageSize;
													pageNumber = result.pageNumber;
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														records += "<tr><td>" + itemRecord.smCollect + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
																	+ "<td>" + itemRecord.grainkind + "</td></tr>";
													});
													if(pageNumber>1){
														mypage += "<a class='tt' href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(pageNumber != 0){
														mypage += "第" + pageNumber +  "/" + totalPages + "页";
													}
													if(pageNumber<totalPages){
														mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
													}
													mypage += "</p>";
													content = table_head + records + table_tail + mypage;
													infoWindow = new BMap.InfoWindow(content, opts);
												}
											});
											
											// 下一页
											pageUp = function(){
												if(pageNumber < totalPages){
													pageNumber++;
													$.ajax({
														async : false,// 取消异步请求
														type : "POST",
														url : "getFootprintFactoryRecords?smFactory=" + item.smFactory + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
														dataType : "json",
														success : function(result) {
															content = '';
															pageNumber = result.pageNumber;
															var records = "";
															var mypage = "<p style='text-align:right;'>";
															$.each(result.rows, function(keyRecord, itemRecord){
																records += "<tr><td>" + itemRecord.smCollect + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
																	+ "<td>" + itemRecord.grainkind + "</td></tr>";
															});
															if(pageNumber>1){
																mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
															}
															if(pageNumber != 0){
																mypage += "第" + pageNumber + "/" + totalPages + "页";
															}
															if(pageNumber<totalPages){
																mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
															}
															mypage += "</p>";
															content = table_head + records + table_tail + mypage;
															infoWindow.setContent(content);
														}
													});
												}else{
													alert('已到最后一页！');
												}
											}
											// 上一页
											pageDown = function(){
												if(pageNumber > 1){
													pageNumber--;
													$.ajax({
														async : false,// 取消异步请求
														type : "POST",
														url : "getFootprintFactoryRecords?smFactory=" + item.smFactory + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
														dataType : "json",
														success : function(result) {
															content = '';
															var records = "";
															var mypage = "<p style='text-align:right;'>";
															pageNumber = result.pageNumber;
															$.each(result.rows, function(keyRecord, itemRecord){
																records += "<tr><td>" + itemRecord.smCollect + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
																	+ "<td>" + itemRecord.grainkind + "</td></tr>";
															});
															if(pageNumber>1){
																mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
															}
															if(pageNumber != 0){
																mypage += "第" + pageNumber + "/" + totalPages + "页";
															}
															if(pageNumber<totalPages){
																mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
															}
															mypage += "</p>";
															content = table_head + records + table_tail + mypage;
															infoWindow.setContent(content);
														}
													});
												}else{
													alert('已到第一页！');
												}
											}
											map.openInfoWindow(infoWindow, data.points[0]);
											
										});
									//}
								}
							});
						}
					});
				}
			});
       }
       function showDepot(from, to){
       		$.ajax({
				async : true,// 取消异步请求
				type : "POST",
				url : "getFootprintDepotInfo",
				dataType : "json",
				data: 'from='+from+'&to='+to,
				success : function(result) {
					//map.clearOverlays(); 	// 清空所有的覆盖物
					var overlays = map.getOverlays();
					var convertor = new BMap.Convertor();
					$.each(result, function(key, item){
						if(item.longtitude != null && item.latitude != null){
							var pointArr = [];
							var lng = item.longtitude;
							var lat = item.latitude;
							var point = new BMap.Point(lng,lat);
							pointArr.push(point);
							
							convertor.translate(pointArr, 1, 5, function(data){
								if(data.status == 0){
									//for(var i=0;i<data.points.length;i++){
										
										var marker = new BMap.Marker(data.points[0]);
										depotMarkers.push(marker);
										map.addOverlay(marker);
										
										var mytitle = "";
										marker.addEventListener('click', function(){
											mytitle = "<p style='margin-top:5xp;'>粮库编号：" +item.lkbm + "&nbsp;粮库名称：" + item.lkmc + "&nbsp;地址：" + item.lkdz + "</p>";
											var opts = {
												width:500,
												height:450,
												title: mytitle
											};
											
											var content = "";
											var pageNumber = 1;  // 第几页
											//var total = result.total; // 总的记录数
											var totalPages = 1; // 总的页面数
											var pageSize = 1;
											var infoWindow;
											var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
															+ "<caption align='top' style='font-weight:bold;'>粮库采集记录</caption>"
															+"<thead><tr><th>记录编码</th><th>采集者</th><th>手机</th><th>公司</th></tr></thead>";
											var table_tail = "</table>";
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootprintDepotRecords?lkbm=" + item.lkbm + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
												dataType : "json",
												success : function(result) {
													totalPages = result.totalPages;
													pageSize = result.pageSize;
													pageNumber = result.pageNumber;
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														records += "<tr><td>" + itemRecord.smCollection + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
													});
													if(pageNumber>1){
														mypage += "<a class='tt' href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(pageNumber != 0){
														mypage += "第" + pageNumber +  "/" + totalPages + "页";
													}
													if(pageNumber<totalPages){
														mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
													}
													mypage += "</p>";
													content = table_head + records + table_tail + mypage;
													infoWindow = new BMap.InfoWindow(content, opts);
												}
											});
											
											// 下一页
											pageUp = function(){
												if(pageNumber < totalPages){
													pageNumber++;
													$.ajax({
														async : false,// 取消异步请求
														type : "POST",
														url : "getFootprintDepotRecords?lkbm=" + item.lkbm + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
														dataType : "json",
														success : function(result) {
															content = '';
															pageNumber = result.pageNumber;
															var records = "";
															var mypage = "<p style='text-align:right;'>";
															$.each(result.rows, function(keyRecord, itemRecord){
																records += "<tr><td>" + itemRecord.smCollection + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
															});
															if(pageNumber>1){
																mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
															}
															if(pageNumber != 0){
																mypage += "第" + pageNumber + "/" + totalPages + "页";
															}
															if(pageNumber<totalPages){
																mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
															}
															mypage += "</p>";
															content = table_head + records + table_tail + mypage;
															infoWindow.setContent(content);
														}
													});
												}else{
													alert('已到最后一页！');
												}
											}
											// 上一页
											pageDown = function(){
												if(pageNumber > 1){
													pageNumber--;
													$.ajax({
														async : false,// 取消异步请求
														type : "POST",
														url : "getFootprintDepotRecords?lkbm=" + item.lkbm + "&pageNumber=" + pageNumber + '&from='+from+'&to='+to,
														dataType : "json",
														success : function(result) {
															content = '';
															var records = "";
															var mypage = "<p style='text-align:right;'>";
															pageNumber = result.pageNumber;
															$.each(result.rows, function(keyRecord, itemRecord){
																records += "<tr><td>" + itemRecord.smCollection + "</td>"
																	+ "<td>" + itemRecord.collector + "</td>"
																	+ "<td>" + itemRecord.mobile + "</td>"
															});
															if(pageNumber>1){
																mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
															}
															if(pageNumber != 0){
																mypage += "第" + pageNumber + "/" + totalPages + "页";
															}
															if(pageNumber<totalPages){
																mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
															}
															mypage += "</p>";
															content = table_head + records + table_tail + mypage;
															infoWindow.setContent(content);
														}
													});
												}else{
													alert('已到第一页！');
												}
											}
											map.openInfoWindow(infoWindow, data.points[0]);
										});
									//}
								}
							});
						}
					});
				}
			});
       }
       function showField(from, to){
       		$.ajax({
				async : true,// 取消异步请求
				type : "POST",
				url : "getFootprintFieldInfo",
				dataType : "json",
				data: 'from='+from+'&to='+to,
				success : function(result) {
					//map.clearOverlays(); 	// 清空所有的覆盖物
					var overlays = map.getOverlays();
					var convertor = new BMap.Convertor();
					$.each(result, function(key, item){
						if(item.longtitude != null && item.latitude != null){
							var pointArr = [];
							var lng = item.longtitude;
							var lat = item.latitude;
							var point = new BMap.Point(lng,lat);
							pointArr.push(point);
							
							convertor.translate(pointArr, 1, 5, function(data){
								if(data.status == 0){
									//for(var i=0;i<data.points.length;i++){
										var marker = new BMap.Marker(data.points[0]);
										fieldMarkers.push(marker);
										map.addOverlay(marker);
										
										marker.addEventListener('click', function(){
											var opts = {
												width:250,
												height:260,
												title: "<p style='text-align:center;'><b>野外采虫</b></p>"
											};
											var content = '记录编码：' + item.id + "<br>";
											content += '采集者：' + item.collector + "<br>";
											content += '手机：' + item.mobile + "<br>";
											content += '粮食名称：' + item.grainkind + "<br><hr>";
											content += '虫种：' + item.kind + "<br>";
											content += '虫态：' + item.stage + "<br>";
											content += '数量：' + item.num + "<br>";
											content += '食性：' + item.food + "<br>";
											content += '危害性：' + item.harm + "<br>";
											
											var infoWindow = new BMap.InfoWindow(content, opts);
											map.openInfoWindow(infoWindow, data.points[0]);
										});
									//}
								}
							});
						}
					});
				}
			});	
       }
       
       $('#collectPlace').combobox({
			multiple:true,
			valueField:'value',
		    textField:'text',
			data:[{
					"text":"农户",
					"value": "farmer",
				},{
					"text":"加工厂",
					"value": "factory",
				},{
					"text":"直属库",
					"value": "depot",
				},{
					"text":"野外",
					"value":"field",
			}],
		});
		
		$("#doSearch").click(function() {
			var from = $('input[name=from]').val();
			var to = $('input[name=to]').val();
			var positions = $("#collectPlace").combobox('getValues');
			if (from == undefined || from == '') {
				$.messager.alert('错误','请选择起始时间！');
				return;
			}
			if (to == undefined || to == '') {
				$.messager.alert('错误','请选择结束时间！');
				return;
			}
			if (positions.length === 0) {
				$.messager.alert('错误','请选择采集地点！');
				return;
			}
			/* parent.$.messager.progress({
				title: '提示',
				text: '数据处理中,请稍后.....'
			}); */
			map.clearOverlays();
			for(var index in positions){
				if(positions[index] === 'farmer'){
					showFarmer(from, to);
				}else if(positions[index] === 'factory'){
					showFactory(from, to);
				}else if(positions[index] === 'depot'){
					showDepot(from, to);
				}else if(positions[index] === 'field'){
					showField(from, to);
				}
			}
		});
		 
	});
</script>	
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<!-- <div region="west" title="过滤条件" style="width:80px;overflow:hidden;">
		<p><input type="checkbox" checked="checked" name="collectPlace" value="farmer" />农户</p>
		<p><input type="checkbox" checked="checked" name="collectPlace" value="factory" />加工厂</p>
		<p><input type="checkbox" checked="checked" name="collectPlace" value="depot" />直属库</p>
		<p><input type="checkbox" checked="checked" name="collectPlace" value="field" />野外</p>
    </div> -->
    
    <div region="north" title="过滤条件" style="height:80px ;overflow:hidden;">
		<div class="input-group" style="margin:10px;">
			时间：
			<input name="from" class="easyui-datebox">
			到
			<input name="to" class="easyui-datebox">
			采集地点:<input id="collectPlace" name="position">
			<a id="doSearch" href="javascript:void(0)" class="easyui-linkbutton" plain="false" iconCls="icon-search">查询</a>
    	</div>
    </div>
	<div data-options="region:'center',split:true" style="overflow: hidden; ">
		<div id="allmap"></div>
	</div>
</body>

</html>
