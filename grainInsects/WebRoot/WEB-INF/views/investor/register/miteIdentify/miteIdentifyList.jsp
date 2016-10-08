<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<jsp:include page="/common/easyui.jsp"></jsp:include>
<head>
	<!-- <#assign content="welcome"> -->
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>main - Powered By Szy++</title>
	<meta name="author" content="Szy++ Team" />
	<meta name="copyright" content="Szy++" />
	<style>
		#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
		.datagrid-editable-input { height : 20px; font-size: 16px; }  // 注意覆盖的顺序
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=${baidu_map_api_account}"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<script type="text/javascript">
		var miteIdentifyList;
		var map;
		$(function(){
			// 百度地图API功能
			map = new BMap.Map("allmap");    // 创建Map实例
			map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
			map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
			map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
			map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
			
			miteIdentifyList=$('#miteIdentifyList').datagrid({
			url: 'getMiteIdentifyList',
			pagination : true,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'sm', // 主键字段
			columns:[[
			          { field : 'sm',
			        	  title :  '编号',
			        	  sortable : true,
			        	  width : 60
			          }, {
			        	  field : 'kind',
			        	  title : '虫种',
			        	 width : 60,
			          },{ field : 'name',
			        	  title :  '学名',
			        	  sortable : true,
			        	  width : 60
			          }, {
			        	  field : 'bintype',
			        	  title : '仓型',
			        	 width : 60,
			          },{ field : 'host',
			        	  title :  '粮种-寄主',
			        	  sortable : true,
			        	  width : 60
			          }, {
			        	  field : 'collector',
			        	  title : '采集人',
			        	 width : 60,
			          }, {
							field : 'actor',
							title : '操作',
							formatter : function(value, row, index) {
								var str = '';
								str += $.formatString(
												'<img onclick="editMiteIdentify(\'{0}\');" src="{1}" title="昆虫鉴定编辑"/>',
												row.sm,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
								str += '&nbsp;';
								str += $.formatString(
												'<img onclick="deleteMiteIdentify(\'{0}\');" src="{1}" title="删除"/>',
												index,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
								return str;
							}
						}
			      ]],
			 	toolbar : '#miteIdentifyListToolbar',
			 	onClickRow : function(rowIndex, rowData){
		        	  miteIdentifyList.datagrid('unselectAll');
		        	  miteIdentifyList.datagrid('selectRow', rowIndex);
		        	  $.ajax({
						async: true,
						type: "POST",
						url: "getSpecFootprint?sm=" + rowData.sm,
						dataType: "json",
						success: function(result){
							map.clearOverlays();
							var convertor = new BMap.Convertor();
							if(result.longtitude != null && result.latitude != null){
								var pointArr = [];
								var lng = result.longtitude;
								var lat = result.latitude;
								var point = new BMap.Point(lng, lat);
								pointArr.push(point);
								convertor.translate(pointArr, 1,5, function(data){
									if(data.status == 0){
										var marker = new BMap.Marker(data.points[0]);
										map.addOverlay(marker);
										
										marker.addEventListener('click', function(){
											var content = "<style type='text/css'>li{line-height:23px;}</style>"
											content += "<li>虫种：" + result.kind 
															+ "<br></li><li>学名：" + result.name
															+ "<br></li><li>仓型：" + result.bintype
															+ "<br></li><li>宿主：" + result.host
															+ "<br></li><li>栖息部位：" + result.habitlocation
															+ "<br></li><li>虫态：" + result.stage
															+ "<br></li><li>采集日期：" + result.collectdate
															+ "<br></li><li>采集者：" + result.collector
															+ "<br></li><li>鉴定人:" + result.identifier
															+ "<br></li><li>复核人:" + result.reviewer
															+ "<br></li><li>留存地:" + result.retainplace
															+ "</li>";
											var searchInfoWindow3 = new BMapLib.SearchInfoWindow(map, content, {
												title: "编号为：&nbsp;" + result.sm + "&nbsp;的详细信息", //标题
												width: 260, //宽度
												height: 300, //高度
												panel : "panel", //检索结果面板
												enableAutoPan : true, //自动平移
												enableSendToPhone: false, //去掉右上角的发送到手机
												searchTypes :[
												]
											});
											searchInfoWindow3.open(data.points[0]);
										});
									}
								});
							}
						}
				  });
		       }
			});
			
			getFootprints(map);
			
		});
		function getFootprints(map){
			$.ajax({
				async: true,
				type: "POST",
				url: "getFootprints",
				dataType: "json",
				success: function(result){
					map.clearOverlays();
					var convertor = new BMap.Convertor();
					$.each(result, function(key, item){
						if(item.longtitude != null && item.latitude != null){
							var pointArr = [];
							var lng = item.longtitude;
							var lat = item.latitude;
							var point = new BMap.Point(lng, lat);
							pointArr.push(point);
							convertor.translate(pointArr, 1,5, function(data){
								if(data.status == 0){
									var marker = new BMap.Marker(data.points[0]);
									map.addOverlay(marker);
									
									marker.addEventListener('click', function(){
										var content = "<style type='text/css'>li{line-height:23px;}</style>"
										content += "<li>虫种：" + item.kind 
														+ "<br></li><li>学名：" + item.name
														+ "<br></li><li>仓型：" + item.bintype
														+ "<br></li><li>宿主：" + item.host
														+ "<br></li><li>栖息部位：" + item.habitlocation
														+ "<br></li><li>虫态：" + item.stage
														+ "<br></li><li>采集日期：" + item.collectdate
														+ "<br></li><li>采集者：" + item.collector
														+ "<br></li><li>玻片制作人：" + item.slideproducer
														+ "<br></li><li>鉴定人:" + item.identifier
														+ "<br></li><li>复核人:" + item.reviewer
														+ "<br></li><li>留存地:" + item.retainplace
														+ "</li>";
										var searchInfoWindow3 = new BMapLib.SearchInfoWindow(map, content, {
											title: "编号为：&nbsp;" + item.sm + "&nbsp;的详细信息", //标题
											width: 260, //宽度
											height: 300, //高度
											panel : "panel", //检索结果面板
											enableAutoPan : true, //自动平移
											enableSendToPhone: false, //去掉右上角的发送到手机
											searchTypes :[
											]
										});
										searchInfoWindow3.open(data.points[0]); 
									});
								}
							});
						}
					});
				}
			});
		}
		function addMiteIdentify(){
			openBlank('addMiteIdentifyEntrance',{} );
		}
		
		function editMiteIdentify(sm){
			openBlank('editMiteIdentifyEntrance', {sm:sm});  // 这里的recordId必须和Controller的变量名一致，否则报错
		}
		
		function deleteMiteIdentify(sm){
			if(sm != undefined){
				miteIdentifyList.datagrid('selectRow', sm);
			}
			var rows = miteIdentifyList.datagrid('getSelections');
			if(rows.length>0){
				parent.$.messager.confirm('询问', '您是否要删除螨虫鉴定信息吗？', function(b){
					if(b){
						parent.$.messager.progress({
							title: '提示',
							text: '数据处理中，请稍候...'
						});
						$.post('miteIdentifyDelete', {
							sm: rows[0].sm
						},function(result){
							if(result.success){
								parent.$.messager.alert('提示',result.msg, 'info');
								miteIdentifyList.datagrid('reload');
							}else {
								parent.$.messager.alert('提示', result.msg, 'error');
							}
							parent.$.messager.progress('close');
						}, 'JSON');
					}
				});
			}
		}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<!-- 这里设置为中间时为自适应 -->
   	<div data-options="region:'center',split:true" title="螨虫鉴定信息列表" style="overflow: hidden;">
		<table id="miteIdentifyList"></table>
	</div>
	<div id="miteIdentifyListToolbar">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:addMiteIdentify()">添加</a>  
        <a onclick="miteIdentifyList.datagrid('reload');miteIdentifyList.datagrid('unselectAll');getFootprints(map);" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
   	</div>
   	<div data-options="region:'east',border:true,split:true" style="overflow: hidden;width:600px">
		<div id="allmap"></div>
	</div>
</body>
</html>