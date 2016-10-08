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
		//map.setCurrentCity("南京");          // 设置地图显示的城市 此项是必须设置的
	  	
		map.addControl(new BMap.NavigationControl());        // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl());             // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl());       //添加缩略地图控件
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		
		$('#insectKinds').combobox({
       		valueField:'insectName',
			textField:'insectName',
			url: 'getAllInsects',
			multiple:true,
			success: function(ret){
				$('#insectKinds').combobox("setValues", ret.rows);
			},
		});
		
		$("#doSearch").click(function() {
			var from = $('input[name=from]').val();
			var to = $('input[name=to]').val();
			var insectKinds = $("#insectKinds").combobox('getValues');
			if (from == undefined || from == '') {
				$.messager.alert('错误','请选择起始时间！');
				return;
			}
			if (to == undefined || to == '') {
				$.messager.alert('错误','请选择结束时间！');
				return;
			}
			if (insectKinds.length === 0) {
				$.messager.alert('错误','请选择虫种！');
				return;
			}
			$.ajax({
				async : true,// 取消异步请求
				type : "POST",
				url : "getInsectDistributes",
				data: "from="+from+"&to="+to+"&insects="+insectKinds,
				dataType : "json",
				success : function(result) {
					console.log(result);
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
									var marker = new BMap.Marker(data.points[0]);
									map.addOverlay(marker);
									
									var mytitle = "xxxx";
									marker.addEventListener('click', function(){
										mytitle = "<p style='margin-top:5xp;'>详细地址：" + item.address + "</p>";
										var opts = {
											width:500,
											height:450,
											title: mytitle
										};
										
										var content = "";
										var table_head = "<table border=1  style='margin-top:10px; *border-collapse: collapse;border-spacing: 0;width: 100%;'>"
														+ "<caption align='top' style='font-weight:bold;'>虫种信息</caption>"
														+"<thead><tr><th>虫种</th><th>虫态</th><th>食性</th><th>危害</th><th>宿主</th><th>数量</th></tr></thead>";
										var table_tail = "</table>";
										var records = "";
										console.log(item.records);
										$.each(item.records, function(keyRecord, itemRecord){
											records += "<tr><td>" + itemRecord.kind + "</td>"
														+ "<td>" + itemRecord.stage + "</td>"
														+ "<td>" + itemRecord.food + "</td>"
														+ "<td>" + itemRecord.harm + "</td>"
														+ "<td>" + itemRecord.host + "</td>"
														+ "<td>" + itemRecord.num + "</td></tr>";
										});
										content = table_head + records + table_tail;
										var infoWindow = new BMap.InfoWindow(content, opts);
										map.openInfoWindow(infoWindow, data.points[0]);
									});
								}
							});
						}
					});
				}
			});	
		});
       
	});
</script>	
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<!-- <div region="west" title="过滤条件" style="width:140px;overflow:hidden;">
		<span style="margin-top: 40px;">
			<input id="cc"/>
		</span>
    </div> -->
    
    <div region="north" title="过滤条件" style="height:80px ;overflow:hidden;">
		<div class="input-group" style="margin:10px;">
			时间：
			<input name="from" class="easyui-datebox">
			到
			<input name="to" class="easyui-datebox">
			虫种:<input id="insectKinds" name="insectKinds">
			<a id="doSearch" href="javascript:void(0)" class="easyui-linkbutton" plain="false" iconCls="icon-search">查询</a>
    	</div>
    </div>
	<div data-options="region:'center',split:true" style="overflow: hidden; ">
		<div id="allmap"></div>
	</div>
</body>

</html>
