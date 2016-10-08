<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path +"/";
%>
<html>
<head>

<style type="text/css">
	#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=${baidu_map_api_account}"></script>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var param = {key:'',value:''}; 
	$(function() {
		function setParam(key, value) {
			param.key = key;
			param.value = value;
		}
		// 百度地图API功能
		var map = new BMap.Map("allmap",{enableMapClick:false});    // 创建Map实例
		var point = new BMap.Point(116.417, 39.909);
		map.centerAndZoom(point, 11);  // 初始化地图,设置中心点坐标和地图级别
		map.addControl(new BMap.ScaleControl());             // 添加比例尺控件
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		
		//点击地图，获取经纬度坐标
        map.addEventListener("click",function(e){
        	console.log(e.point.lng + "--" + e.point.lat);
        });
		
//---------------------------------------------------------------------------------------------------//		
		//4个采集地点
		$('#pos-select').combobox({
			multiple:true,
			data:[{"text":"农户"},{"text":"加工厂"},{"text":"粮库"},{"text":"野外"}],
		    valueField:'text',
		    textField:'text'
		});
		//采集单位
		$.getJSON('companyNameList', function(result) {
			result.rows.unshift({"text":"全选"});
			data = result.rows;
			$('#comp-select').combobox({
				multiple:true,
				data:data,
			    valueField:'text',
			    textField:'text',
			    onLoadSuccess: function () { //加载完成后,设置选中第一项
	                var val = $(this).combobox("getData");
	                for (var item in val[0]) {
	                    if (item == "text") {
	                        $(this).combobox("select", val[0][item]);
	                    }
	                }
	            },//end fo onLoadSuccess
	            onSelect:function() {
			    	var company = $(this);
			    	var ids = company.combobox('getValues');
			    	if(ids.indexOf('全选') == -1) {
			    		console.log('selected');
			    		setParam('texts', company.combobox('getValues'));
			    	} else {
			    		var values = [];
			    		company.combobox('getData').forEach(function(value) {
				    		if (value.text != '全选') {
				    			values.push(value.text);
				    			company.combobox('unselect', value.text);
				    		}
				    	});
			    		setParam('texts', values);
			    	}
			    },//end of onSelect
			    onUnselect: function() {
			    	var company = $(this);
			    	var ids = company.combobox('getValues');
			    	if(ids.indexOf('全选') == -1) {
			    		setParam('texts', company.combobox('getValues'));
			    	} else {
			    		setParam('texts', []);
			    	}
			    }//end of onUnSelect
			});
		});
	
		$("#doSearch").click(function() {
			var from = $('input[name=from]').val();
			var to = $('input[name=to]').val();
			var positions = $("#pos-select").combobox('getValues');
			var company = $("#comp-select").combobox('getValues');
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
			if (company.length === 0) {
				$.messager.alert('错误','请选择单位！');
				return;
			}
			parent.$.messager.progress({
				title: '提示',
				text: '数据处理中,请稍后.....'
			});
			company = [].concat(param.value);
			$.post('footmarkDoSearchList',{startTime:from,endTime:to,pos:positions,comp:company},function(result){
				map.clearOverlays(); 	// 清空所有的覆盖物
				var convertor = new BMap.Convertor();
				var pointArr2 = [];
				parent.$.messager.progress('close');
				$.each(result.rows,function(key,item){
					var pointArr = [];
					var lng = item.longitude;
					var lat = item.latitude;
					var point = new BMap.Point(lng,lat);
					pointArr.push(point);
					convertor.translate(pointArr, 1, 5, function(data){
						if(data.status == 0){
							var marker = new BMap.Marker(data.points[0]);
							map.addOverlay(marker);
							//自动缩放---
							pointArr2.push(data.points[0]);
							//console.log(pointArr2);
							map.setViewport(pointArr2);  
							//---自动缩放
							
							var mytitle = "";
							marker.addEventListener('click', function(){
								//农户
								if(item.position == "farmer"){
									mytitle = "<p style='margin-top:5xp;'>农户编号：" +item.sm + "&nbsp;户主名：" + item.name + "&nbsp;地址：" + item.address + "</p>";
									var opts = {
										width:500,
										height:250,
										title: mytitle
									};
									var smFarmer=item.sm;
									//console.log(smFarmer);
									var content = "";
									var currentPage = 1;  // 第几页
									//var total = result.total; // 总的记录数
									var totalPages = 1; // 总的页面数
									var pageSize = 5;
									var infoWindow;
									var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
													+ "<caption align='top' style='font-weight:bold;'>农户采集记录</caption>"
													+"<thead><tr><th>记录编码</th><th>采集者</th><th>采集日期</th><th>虫种</th><th>虫态</th><th>数量</th><th>危害性</th></tr></thead>";
									var table_tail = "</table>";
									$.ajax({
										async : false,// 取消异步请求
										type : "POST",
										url : "getFootmarkFarmerListRecords",
										data:{startTime:from,endTime:to,comp:company,farmer:smFarmer},
										dataType : "json",
										success : function(result) {
											totalPages = Math.ceil(result.total/pageSize);
											var records = "";
											var mypage = "<p style='text-align:right;'>";
											$.each(result.rows, function(keyRecord, itemRecord){
												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
													records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																+ "<td>" + itemRecord.collector + "</td>"
																+ "<td>" + itemRecord.date_collection + "</td>"
																+ "<td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.stage + "</td>"
																+ "<td>" + itemRecord.num + "</td>"
																+ "<td>" + itemRecord.harm + "</td></tr>";
												}
											});
											//console.log(content);
											if(currentPage>1){
												mypage += "<p style='text-align:right;'><a class='tt' href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
											}
											if(currentPage != 0){
												mypage += "第" + currentPage +  "/" + totalPages + "页";
											}
											if(currentPage<totalPages){
												mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
											}
											mypage += "</p>";
											content = table_head + records + table_tail + mypage;
											infoWindow = new BMap.InfoWindow(content, opts);
										}
									});
									
									// 下一页
									pageUp = function(){
										if(currentPage < totalPages){
											currentPage++;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkFarmerListRecords",
												data:{startTime:from,endTime:to,comp:company,farmer:smFarmer},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													//console.log(content);
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
										if(currentPage > 1){
											currentPage--;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkFarmerListRecords",
												data:{startTime:from,endTime:to,comp:company,farmer:smFarmer},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
								}//end of if farmer
								
								//粮库
								if(item.position == "depot"){
									mytitle = "<p style='margin-top:5xp;'>粮库编号：" +item.sm + "&nbsp;粮库名称：" + item.name + "&nbsp;地址：" + item.address + "</p>";
									var opts = {
										width:500,
										height:250,
										title: mytitle
									};
									var smGrainbin=item.sm;
									//console.log(smFarmer);
									var content = "";
									var currentPage = 1;  // 第几页
									//var total = result.total; // 总的记录数
									var totalPages = 1; // 总的页面数
									var pageSize = 5;
									var infoWindow;
									var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
													+ "<caption align='top' style='font-weight:bold;'>粮库采集记录</caption>"
													+"<thead><tr><th>记录编码</th><th>采集者</th><th>采集日期</th><th>虫种</th><th>虫态</th><th>数量</th><th>危害性</th></tr></thead>";
									var table_tail = "</table>";
									$.ajax({
										async : false,// 取消异步请求
										type : "POST",
										url : "getFootmarkBinListRecords",
										data:{startTime:from,endTime:to,comp:company,grainbin:smGrainbin},
										dataType : "json",
										success : function(result) {
											totalPages = Math.ceil(result.total/pageSize);
											var records = "";
											var mypage = "<p style='text-align:right;'>";
											$.each(result.rows, function(keyRecord, itemRecord){
												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
													records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																+ "<td>" + itemRecord.collector + "</td>"
																+ "<td>" + itemRecord.date_collection + "</td>"
																+ "<td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.stage + "</td>"
																+ "<td>" + itemRecord.num + "</td>"
																+ "<td>" + itemRecord.harm + "</td></tr>";
												}
											});
											//console.log(content);
											if(currentPage>1){
												mypage += "<p style='text-align:right;'><a class='tt' href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
											}
											if(currentPage != 0){
												mypage += "第" + currentPage +  "/" + totalPages + "页";
											}
											if(currentPage<totalPages){
												mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
											}
											mypage += "</p>";
											content = table_head + records + table_tail + mypage;
											infoWindow = new BMap.InfoWindow(content, opts);
										}
									});
									
									// 下一页
									pageUp = function(){
										if(currentPage < totalPages){
											currentPage++;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkBinListRecords",
												data:{startTime:from,endTime:to,comp:company,grainbin:smGrainbin},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													//console.log(content);
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
										if(currentPage > 1){
											currentPage--;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkBinListRecords",
												data:{startTime:from,endTime:to,comp:company,grainbin:smGrainbin},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
								}//end of if depot
								
								//加工厂
								if(item.position == "factory"){
									mytitle = "<p style='margin-top:5xp;'>加工厂编号：" +item.sm + "&nbsp;加工厂名称：" + item.name + "&nbsp;地址：" + item.address + "</p>";
									var opts = {
										width:500,
										height:250,
										title: mytitle
									};
									var smFactory=item.sm;
									//console.log(smFarmer);
									var content = "";
									var currentPage = 1;  // 第几页
									//var total = result.total; // 总的记录数
									var totalPages = 1; // 总的页面数
									var pageSize = 5;
									var infoWindow;
									var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
													+ "<caption align='top' style='font-weight:bold;'>加工厂采集记录</caption>"
													+"<thead><tr><th>记录编码</th><th>采集者</th><th>采集日期</th><th>虫种</th><th>虫态</th><th>数量</th><th>危害性</th></tr></thead>";
									var table_tail = "</table>";
									$.ajax({
										async : false,// 取消异步请求
										type : "POST",
										url : "getFootmarkInsectsOnfactoryListRecords",
										data:{startTime:from,endTime:to,comp:company,factoryInfo:smFactory},
										dataType : "json",
										success : function(result) {
											totalPages = Math.ceil(result.total/pageSize);
											var records = "";
											var mypage = "<p style='text-align:right;'>";
											$.each(result.rows, function(keyRecord, itemRecord){
												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
													records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																+ "<td>" + itemRecord.collector + "</td>"
																+ "<td>" + itemRecord.date_collection + "</td>"
																+ "<td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.stage + "</td>"
																+ "<td>" + itemRecord.num + "</td>"
																+ "<td>" + itemRecord.harm + "</td></tr>";
												}
											});
											//console.log(content);
											if(currentPage>1){
												mypage += "<p style='text-align:right;'><a class='tt' href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
											}
											if(currentPage != 0){
												mypage += "第" + currentPage +  "/" + totalPages + "页";
											}
											if(currentPage<totalPages){
												mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
											}
											mypage += "</p>";
											content = table_head + records + table_tail + mypage;
											infoWindow = new BMap.InfoWindow(content, opts);
										}
									});
									
									// 下一页
									pageUp = function(){
										if(currentPage < totalPages){
											currentPage++;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkInsectsOnfactoryListRecords",
												data:{startTime:from,endTime:to,comp:company,factoryInfo:smFactory},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													//console.log(content);
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
										if(currentPage > 1){
											currentPage--;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkInsectsOnfactoryListRecords",
												data:{startTime:from,endTime:to,comp:company,factoryInfo:smFactory},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
								}//end of if factory
								
								//野外
								if(item.position == "field"){
									mytitle = "<p style='margin-top:5xp;'>野外采集</p>";
									var opts = {
										width:500,
										height:250,
										title: mytitle
									};
									var ID=item.sm;
									//console.log(smFarmer);
									var content = "";
									var currentPage = 1;  // 第几页
									//var total = result.total; // 总的记录数
									var totalPages = 1; // 总的页面数
									var pageSize = 5;
									var infoWindow;
									var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
													+ "<caption align='top' style='font-weight:bold;'>野外采集记录</caption>"
													+"<thead><tr><th>记录编码</th><th>采集者</th><th>采集日期</th><th>虫种</th><th>虫态</th><th>数量</th><th>危害性</th></tr></thead>";
									var table_tail = "</table>";
									$.ajax({
										async : false,// 取消异步请求
										type : "POST",
										url : "getFootmarkInsectOnfieldListRecords",
										data:{startTime:from,endTime:to,comp:company,longtitude:lng,latitude:lat},
										dataType : "json",
										success : function(result) {
											totalPages = Math.ceil(result.total/pageSize);
											var records = "";
											var mypage = "<p style='text-align:right;'>";
											$.each(result.rows, function(keyRecord, itemRecord){
												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
													records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																+ "<td>" + itemRecord.collector + "</td>"
																+ "<td>" + itemRecord.date_collection + "</td>"
																+ "<td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.stage + "</td>"
																+ "<td>" + itemRecord.num + "</td>"
																+ "<td>" + itemRecord.harm + "</td></tr>";
												}
											});
											//console.log(content);
											if(currentPage>1){
												mypage += "<p style='text-align:right;'><a class='tt' href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
											}
											if(currentPage != 0){
												mypage += "第" + currentPage +  "/" + totalPages + "页";
											}
											if(currentPage<totalPages){
												mypage += "<a href='javascript:void(0)' onclick=pageUp()>下一页</a><br>";
											}
											mypage += "</p>";
											content = table_head + records + table_tail + mypage;
											infoWindow = new BMap.InfoWindow(content, opts);
										}
									});
									
									// 下一页
									pageUp = function(){
										if(currentPage < totalPages){
											currentPage++;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkInsectOnfieldListRecords",
												data:{startTime:from,endTime:to,comp:company,longtitude:lng,latitude:lat},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													//console.log(content);
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
										if(currentPage > 1){
											currentPage--;
											$.ajax({
												async : false,// 取消异步请求
												type : "POST",
												url : "getFootmarkInsectOnfieldListRecords",
												data:{startTime:from,endTime:to,comp:company,longtitude:lng,latitude:lat},
												dataType : "json",
												success : function(result) {
													totalPages = Math.ceil(result.total/pageSize);
													var records = "";
													var mypage = "<p style='text-align:right;'>";
													$.each(result.rows, function(keyRecord, itemRecord){
														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
															records += "<tr><td>" + itemRecord.sm_collection + "</td>"
																		+ "<td>" + itemRecord.collector + "</td>"
																		+ "<td>" + itemRecord.date_collection + "</td>"
																		+ "<td>" + itemRecord.kind + "</td>"
																		+ "<td>" + itemRecord.stage + "</td>"
																		+ "<td>" + itemRecord.num + "</td>"
																		+ "<td>" + itemRecord.harm + "</td></tr>";
														}
													});
													if(currentPage>1){
														mypage += "<a href='javascript:void(0)' onclick=pageDown()>上一页</a>&nbsp;";
													}
													if(currentPage != 0){
														mypage += "第" + currentPage + "/" + totalPages + "页";
													}
													if(currentPage<totalPages){
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
								}//end of if field
							});//end of marker.click
						}//end of if
					});//end of gps translate
				});//end of each
			});//end of $.post
			
		});//end of doSearch.click
	});
	
</script>	
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div region="north" title="过滤条件" style="height:80px ;overflow:hidden;">
		<div class="input-group" style="margin:10px;">
			时间：
			<input name="from" class="easyui-datebox">
			到
			<input name="to" class="easyui-datebox">
			采集地点:<input id="pos-select" name="position" value="">
			单位：<input id="comp-select" name="company" value="">
			<a id="doSearch" href="javascript:void(0)" class="easyui-linkbutton" plain="false" iconCls="icon-search">查询</a>
    	</div>
    </div>
	<div data-options="region:'center',split:true" style="overflow: hidden; ">
		<div id="allmap"></div>
	</div>
	
</body>
</html>
