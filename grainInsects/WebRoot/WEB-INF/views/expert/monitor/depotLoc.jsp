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
   		function setParam(key, value) {
			param.key = key;
			param.value = value;
		}
		function disableInput(params) {
			params.forEach(function(param) {
				$(param.element).attr('disabled', param.disabled);
				try	{
					if (param.disabled) {
						$(param.element).combobox('disable');
						$(param.element).combobox('clear');
					} else {
						$(param.element).combobox('enable');
					}
				} catch(e) {
					
				}
				
			});
		}
		//加载储粮区
		function loadDirections() {
			$.getJSON('getGrainDirections', function(result) {
				result.push({
					id:'-1',
					name:'全部储粮区'
				});
				$('#direction').combobox({
					data:result,
				    valueField:'id',
				    textField:'name',
				    onSelect:function() {
				    	var id = $(this).combobox('getValue');
				    	setParam('directionId', id);
				    	if (id != -1) {
				    		loadAreas(id);
				    		disableInput([{
				    			element:'#area',
				    			disabled:false
				    			},{
				    			element:'#depot',
				    			disabled:true
				    			}]);
				    	} else {
				    		disableInput([{
				    			element:'#area',
				    			disabled:true
				    			},{
				    			element:'#depot',
				    			disabled:true
				    			}]);
				    	}
				    }
				});
				$('#direction').combobox('select', -1);
			});	
		}
		//加载行政区
		function loadAreas(id) {
			$.getJSON('getAreas?grainDirectionsId=' + id, function(result) {
				result.push({
					id:-1,
					name:'全部行政区'
				});
				$('#area').combobox({
					data:result,
				    valueField:'id',
				    textField:'name',
				    onSelect:function() {
				    	var id = $(this).combobox('getValue');
				    	if (id != '-1') {
				    		setParam('areaId', id);
				    		loadDepots(id);
				    		disableInput([{
				    			element:'#depot',
				    			disabled:false
				    			}]);
				    	} else {
				    		setParam('directionId', $('#direction').combobox('getValue'));
				    		disableInput([{
				    			element:'#depot',
				    			disabled:true
				    			}]);
				    	}
				    }
				});
				$('#area').combobox('select', -1);
			});	
		}
		//加载粮库
		function loadDepots(id) {
			$.getJSON('grainDepots?areaId=' + id, function(result) {
				result.push({
					lkbm:-1,
					lkmc:'全部粮库'
				});
				$('#depot').combobox({
					data:result,
				    valueField:'lkbm',
				    textField:'lkmc',
				    multiple:true,
				    onSelect:function() {
				    	var depot = $(this);
				    	var ids = depot.combobox('getValues');
				    	if(ids.indexOf('-1') == -1) {
			    			setParam('lkbms', depot.combobox('getValues'));
			    			return;
			    		}
				    	if (ids.length == 1) {
				    		setParam('areaId', $('#area').combobox('getValue'));
				    	} else {
				    		if(ids.indexOf('-1') == 0) {// 选中全部后 又选中单项
				    			depot.combobox('unselect', -1);
				    			setParam('lkbms', depot.combobox('getValues'));
				    		} else {
				    			depot.combobox('getData').forEach(function(value) {
					    			if(value.lkbm != -1) {
					    				depot.combobox('unselect', value.lkbm);
					    			}
					    		});
				    			setParam('areaId', $('#area').combobox('getValue'));
				    		}
				    	}
				    },
				    onUnselect: function() {
				    	var depot = $(this);
				    	var ids = depot.combobox('getValues');
				    	if(ids.length == 0) {
				    		depot.combobox('select', -1);
				    		return;
				    	}
				    	setParam('lkbms', ids);
				    }
				});
				$('#depot').combobox('select', -1);
			});	
		};
		loadDirections();
   	
   		$("#doSearch").click(function() {
   			console.log(param);
 
   			parent.$.messager.progress({
   				title: '提示',
   				text: '数据处理中,请稍后.....'
   			}); 
   			var query = {};
   			if (param.key != 'directionId' || param.value != '-1') {
   				query[param.key] = param.value;	
   			}
   			$.post('grainDepotsLoc', query,function(result){
   				map.clearOverlays(); 	// 清空所有的覆盖物
   				var convertor = new BMap.Convertor();
   				var pointArr2 = [];
   				parent.$.messager.progress('close');//加载框结束
   				$.each(result,function(key,item){
   					var pointArr = [];
   					var lng = item.longtitude;
   					var lat = item.latitude;
   					console.log(item);
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
   							marker.addEventListener('click', function(){
   									var title = "示范库名称:&nbsp" + item.lkmc;
   									var content = "<p>示范库编码:&nbsp" + item.lkbm + "</p>";
   									content += "<p>示范库地址:&nbsp" + item.lkdz + "</p>";
   									content += "<p>邮编:" + item.postcode + "</p>";
   									content += "<p>示范库位置：经度&nbsp" + lng +"，纬度&nbsp" + lat + "，海拔" + item.altitude + "</p>";
   									content += "<p>粮仓数:" + item.totalbin + "</p>";
   									content += "<p>联系人:" + item.contact + "</p>";
   									content += "<p>联系电话:" + item.phone + "</p>";
   									var href = "expert/monitor/insectsTemperatureHunmidity#lkbm=" + item.lkbm ;
   									content += '<p><a href="javascript:void(0)" onclick="self.parent.addTabByTitleAndUrl(\'数据监控\', \'' + href + '\')">数据监控</a></p>';
   									var opts = {
										width:200,
										height:300,
										title: title
									};
   									infoWindow = new BMap.InfoWindow(content, opts);
   									map.openInfoWindow(infoWindow, data.points[0]);
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
	<div region="north" title="监测预报 > 示范库分布 > 过滤条件" style="height:80px ;overflow:hidden;">
		<div class="input-group" style="margin:10px;">
			储粮区:<input id="direction"  value="">

			行政区:<input id="area"  value="" disabled='disabled'>
	
			示范库:<input id="depot"  value="" disabled='disabled'>
			<a id="doSearch" href="javascript:void(0)" class="easyui-linkbutton" plain="false" iconCls="icon-search">查询</a>
    	</div>
    </div>
	<div data-options="region:'center',split:true" style="overflow: hidden; " title="监测预报>示范库分布">
		<div id="allmap"></div>
	</div>
	
</body>
</html>
