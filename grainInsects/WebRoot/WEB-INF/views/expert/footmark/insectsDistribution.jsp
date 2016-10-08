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
	var param2 = {key:'',value:''}; 
	$(function() {
		function setParam(key, value) {
			param.key = key;
			param.value = value;
		}
		function setParam2(key, value) {
			param2.key = key;
			param2.value = value;
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
   		//选择虫种
   		$.getJSON('insectKindList', function(result) {
   			result.rows.unshift({"text":"全选"});
   			types = result.rows;
   			//types = [{"text":"chongq"},{"text":"chongb"}];
   			$('#kind-select').combobox({
    			multiple:true,
    			data:types,
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
			    	var kind = $(this);
			    	var ids = kind.combobox('getValues');
			    	if(ids.indexOf('全选') == -1) {
			    		console.log('selected');
			    		setParam2('kind', kind.combobox('getValues'));
			    	} else {
			    		var values = [];
			    		kind.combobox('getData').forEach(function(value) {
				    		if (value.text != '全选') {
				    			values.push(value.text);
				    			kind.combobox('unselect', value.text);
				    		}
				    	});
			    		setParam2('kind', values);
			    	}
			    },//end of onSelect
			    onUnselect: function() {
			    	var kind = $(this);
			    	var ids = kind.combobox('getValues');
			    	if(ids.indexOf('全选') == -1) {
			    		setParam2('kind', kind.combobox('getValues'));
			    	} else {
			    		setParam2('kind', []);
			    	}
			    }//end of onUnSelect
    		});
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
			    		setParam('comp', company.combobox('getValues'));
			    	} else {
			    		var values = [];
			    		company.combobox('getData').forEach(function(value) {
				    		if (value.text != '全选') {
				    			values.push(value.text);
				    			company.combobox('unselect', value.text);
				    		}
				    	});
			    		setParam('comp', values);
			    	}
			    },//end of onSelect
			    onUnselect: function() {
			    	var company = $(this);
			    	var ids = company.combobox('getValues');
			    	if(ids.indexOf('全选') == -1) {
			    		setParam('comp', company.combobox('getValues'));
			    	} else {
			    		setParam('comp', []);
			    	}
			    }//end of onUnSelect
			});
		});
   	
   		$("#doSearch").click(function() {
   			var from = $('input[name=from]').val();
   			var to = $('input[name=to]').val();
   			var kinds = $("#kind-select").combobox('getValues');
   			var company = $("#comp-select").combobox('getValues');
   			if (from == undefined || from == '') {
   				$.messager.alert('错误','请选择起始时间！');
   				return;
   			}
   			if (to == undefined || to == '') {
   				$.messager.alert('错误','请选择结束时间！');
   				return;
   			}
   			if (kinds.length === 0) {
   				$.messager.alert('错误','请选择虫种！');
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
   			kinds = [].concat(param2.value);
   			$.post('insectsDistributionDoSearchList',{startTime:from,endTime:to,pos:['农户','加工厂','粮库','野外'],comp:company,kind:kinds},function(result){
   				map.clearOverlays(); 	// 清空所有的覆盖物
   				var pointArr2 = [];
   				var convertor = new BMap.Convertor();
   				parent.$.messager.progress('close');//加载框结束
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
   									mytitle = "<p>害虫位置：经度&nbsp" + lng +"，纬度&nbsp" + lat + "</p>";
   									var opts = {
										width:450,
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
   									var table_head = "<table border=1  style='*border-collapse: collapse;border-spacing: 0;width: 100%;'>"
   													+ "<caption align='top' style='font-weight:bold;'>害虫信息</caption>"
   													+"<thead><tr><th>虫种</th><th>食性</th><th>寄主</th><th>危害性</th><th>防虫措施</th></tr></thead>";
   									var table_tail = "</table>";
   									$.ajax({
   										async : false,// 取消异步请求
   										type : "POST",
   										url : "getinsectsDistributionFarmerListRecords",
   										data:{startTime:from,endTime:to,comp:company,farmer:smFarmer,kind:kinds},
   										dataType : "json",
   										success : function(result) {
   											totalPages = Math.ceil(result.total/pageSize);
   											var records = "";
   											var mypage = "<p style='text-align:right;'>";
   											$.each(result.rows, function(keyRecord, itemRecord){
   												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   													records += "<tr><td>" + itemRecord.kind + "</td>"
   																+ "<td>" + itemRecord.food + "</td>"
   																+ "<td>" + itemRecord.host + "</td>"
   																+ "<td>" + itemRecord.harm + "</td>"
   																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionFarmerListRecords",
   												data:{startTime:from,endTime:to,comp:company,farmer:smFarmer,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionFarmerListRecords",
   												data:{startTime:from,endTime:to,comp:company,farmer:smFarmer,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   									mytitle = "<p>害虫位置：经度&nbsp" + lng +"，纬度&nbsp" + lat + "</p>";
   									var opts = {
										width:450,
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
   											+ "<caption align='top' style='font-weight:bold;'>害虫信息</caption>"
											+"<thead><tr><th>虫种</th><th>食性</th><th>寄主</th><th>危害性</th><th>防虫措施</th></tr></thead>";
   									var table_tail = "</table>";
   									$.ajax({
   										async : false,// 取消异步请求
   										type : "POST",
   										url : "getinsectsDistributionBinListRecords",
   										data:{startTime:from,endTime:to,comp:company,grainbin:smGrainbin,kind:kinds},
   										dataType : "json",
   										success : function(result) {
   											totalPages = Math.ceil(result.total/pageSize);
   											var records = "";
   											var mypage = "<p style='text-align:right;'>";
   											$.each(result.rows, function(keyRecord, itemRecord){
   												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   													records += "<tr><td>" + itemRecord.kind + "</td>"
														+ "<td>" + itemRecord.food + "</td>"
														+ "<td>" + itemRecord.host + "</td>"
														+ "<td>" + itemRecord.harm + "</td>"
														+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionBinListRecords",
   												data:{startTime:from,endTime:to,comp:company,grainbin:smGrainbin,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionBinListRecords",
   												data:{startTime:from,endTime:to,comp:company,grainbin:smGrainbin,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   									mytitle = "<p>害虫位置：经度&nbsp" + lng +"，纬度&nbsp" + lat + "</p>";
   									var opts = {
										width:450,
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
   											+ "<caption align='top' style='font-weight:bold;'>害虫信息</caption>"
											+"<thead><tr><th>虫种</th><th>食性</th><th>寄主</th><th>危害性</th><th>防虫措施</th></tr></thead>";
   									var table_tail = "</table>";
   									$.ajax({
   										async : false,// 取消异步请求
   										type : "POST",
   										url : "getinsectsDistributionInsectsOnfactoryListRecords",
   										data:{startTime:from,endTime:to,comp:company,factoryInfo:smFactory,kind:kinds},
   										dataType : "json",
   										success : function(result) {
   											totalPages = Math.ceil(result.total/pageSize);
   											var records = "";
   											var mypage = "<p style='text-align:right;'>";
   											$.each(result.rows, function(keyRecord, itemRecord){
   												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   													records += "<tr><td>" + itemRecord.kind + "</td>"
														+ "<td>" + itemRecord.food + "</td>"
														+ "<td>" + itemRecord.host + "</td>"
														+ "<td>" + itemRecord.harm + "</td>"
														+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionInsectsOnfactoryListRecords",
   												data:{startTime:from,endTime:to,comp:company,factoryInfo:smFactory,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionInsectsOnfactoryListRecords",
   												data:{startTime:from,endTime:to,comp:company,factoryInfo:smFactory,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   									mytitle = "<p>害虫位置：经度&nbsp" + lng +"，纬度&nbsp" + lat + "</p>";
   									var opts = {
										width:450,
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
   											+ "<caption align='top' style='font-weight:bold;'>害虫信息</caption>"
											+"<thead><tr><th>虫种</th><th>食性</th><th>寄主</th><th>危害性</th><th>防虫措施</th></tr></thead>";
   									var table_tail = "</table>";
   									$.ajax({
   										async : false,// 取消异步请求
   										type : "POST",
   										url : "getinsectsDistributionInsectOnfieldListRecords",
   										data:{startTime:from,endTime:to,comp:company,longtitude:lng,latitude:lat,kind:kinds},
   										dataType : "json",
   										success : function(result) {
   											totalPages = Math.ceil(result.total/pageSize);
   											var records = "";
   											var mypage = "<p style='text-align:right;'>";
   											$.each(result.rows, function(keyRecord, itemRecord){
   												if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   													records += "<tr><td>" + itemRecord.kind + "</td>"
														+ "<td>" + itemRecord.food + "</td>"
														+ "<td>" + itemRecord.host + "</td>"
														+ "<td>" + itemRecord.harm + "</td>"
														+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionInsectOnfieldListRecords",
   												data:{startTime:from,endTime:to,comp:company,longtitude:lng,latitude:lat,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
   												url : "getinsectsDistributionInsectOnfieldListRecords",
   												data:{startTime:from,endTime:to,comp:company,longtitude:lng,latitude:lat,kind:kinds},
   												dataType : "json",
   												success : function(result) {
   													totalPages = Math.ceil(result.total/pageSize);
   													var records = "";
   													var mypage = "<p style='text-align:right;'>";
   													$.each(result.rows, function(keyRecord, itemRecord){
   														if(keyRecord < (currentPage*pageSize) && keyRecord >= (currentPage-1)*pageSize){
   															records += "<tr><td>" + itemRecord.kind + "</td>"
																+ "<td>" + itemRecord.food + "</td>"
																+ "<td>" + itemRecord.host + "</td>"
																+ "<td>" + itemRecord.harm + "</td>"
																+ "<td>" + itemRecord.protectmeasure + "</td></tr>";
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
			虫种:<input id="kind-select" name="kind" value="">
			单位:<input id="comp-select" name="company" value="">
			<a id="doSearch" href="javascript:void(0)" class="easyui-linkbutton" plain="false" iconCls="icon-search">查询</a>
    	</div>
    </div>
	<div data-options="region:'center',split:true" style="overflow: hidden; ">
		<div id="allmap"></div>
	</div>
	
</body>
</html>
