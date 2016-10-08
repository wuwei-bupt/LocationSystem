<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>储粮区维护</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<style type="text/css">
	#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=${baidu_map_api_account}"></script>
<!-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=9biyZTW9EpyLbYf7rFr4RHv1KwkeIVB3"></script> -->
<script type="text/javascript">
	//var dataGrid;
	var places = new Array();
	$(function() {
	
		var map = new BMap.Map("allmap");    // 创建Map实例
		var point = new BMap.Point(116.417, 39.909);
		map.centerAndZoom(point, 11);  // 初始化地图,设置中心点坐标和地图级别
		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	  	
		map.addControl(new BMap.NavigationControl());        // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl());             // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl());       //添加缩略地图控件
		
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		
		showFlash("${FlashMessage}");
		
		editrow = 'undefined'; //行编辑开关
		dataGrid = $('#dataGrid').datagrid({
		url : 'getdata',
		title : "储粮区维护",
		iconCls : "icon-tip",// 图标css,见icon.css
		pagination : true,
		//pagePosition :'top', //默认bottom 分页工具栏的位置：  'top','bottom','both' （下图就是在底部）
		fit : true,
		rownumbers : true,// 显示行号
		singleSelect : true,// 只能单选
		border : true,
		striped : true,// 隔行变色
		idField : 'id', // 主键字段
		frozenColumns : [ [ {
			field : 'actor',
			title : '操作',
			width : 60,
			formatter : function(value, row, index) {
				var str = '';
				str += $.formatString(
								'<img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/>',
								index,
								'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
				str += '&nbsp;';
				str += $.formatString(
								'<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/>',
								index,
								'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
				return str;
			}
		},{
			field : 'id',
			title : 'ID',
			align : 'center',
			width : 60,
			sortable : true,
		},] ],
		columns : [ [
				{	field : 'fullname',
					title : '名称',
					align : 'center',
					width : 150,
					sortable : true,
					editor : {type : 'validatebox',options : {required : true} 	}
				}, ] ],
			toolbar : '#toolbar',

			onLoadSuccess : function() {
				parent.$.messager.progress('close');
				
				$(this).datagrid('tooltip');
			},
				//ply.setFillOpacity(0.1);
										/* ply.addEventListener("click", function(e){
											var latlng = e.point;
											var info = new BMap.InfoWindow(item, {width:110});
											map.openInfoWindow(info, latlng);
											
											//高亮闪烁显示鼠标点击的省
										    var delay = 0;
										    for (var flashTimes = 0; flashTimes < 3; flashTimes++) {
										        delay += 200;
										        setTimeout(function () {
										            ply.setFillColor("#FFFF00");
										        }, delay);
										
										        delay += 200;
										        setTimeout(function () {
										            ply.setFillColor("#AAFFEE");
										        }, delay);
										    }
										}); */
			onClickRow : function(rowIndex, rowData){
		      $.ajax({
				async : true, //异步进行操作
				type : "POST",
				url : "getAreas?id=" + rowData.id,
				dataType : "json",
				success : function(result) {
							map.clearOverlays();
							places = [];
						//	var places = new Array();
							$.each(result, function(key, item){
								var bdary = new BMap.Boundary();
								bdary.get(item, function(rs){
									var count = rs.boundaries.length;
									for(var i=0;i<count;i++){
										var ply = new BMap.Polygon(rs.boundaries[i],{strokeWeight:1,strokeColor:"#ff0000"});
										ply.addEventListener('mouseover', function(e){
											var latlng = e.point;
											var info = new BMap.InfoWindow(item, {});
											map.openInfoWindow(info, latlng);
											ply.setFillColor("#00FF00");
										});
										
										map.addOverlay(ply);
										var mypath = ply.getPath();
										for(var j=0;j<mypath.length;j++){
											places.push(mypath[j]);
										}
									}
								});
							});
							//设置时间延迟，便于展示全景
							setTimeout(function () {
											map.setViewport(places);
								        }, 1000);
						}
				});
		      	 
		    },
			onAfterEdit : function(rowIndex, rowData, changes) {
				afterEdit(rowIndex, rowData, changes);
			}
		});
		
		dataGrid.datagrid('getPager').pagination({    
		    showPageList:true,    
		    buttons:[{    
		        iconCls:'icon-add', 
		        text : '添加',
		        handler:function(){    
		        	addFun();    
		        }    
		    },{    
		        iconCls:'icon-save',
		        text :'保存',
		        handler:function(){    
		        	saveFun();    
		        }    
		    },{    
		        iconCls:'icon-redo',
		        text :'撤销',
		        handler:function(){    
		        	cancelFun();    
		        }    
		    },{    
		        iconCls:'transmit',
		        text :'刷新',
		        handler:function(){    
		        	dataGrid.datagrid('reload');  
		        }    
		    }],    
		    onBeforeRefresh:function(){    
		       // alert('before refresh');    
		        return true;    
		    }    
		});   
	});

	function afterEdit(rowIndex, rowData, changes) {
		var inserted = dataGrid.datagrid('getChanges', 'inserted');
		var updated = dataGrid.datagrid('getChanges', 'updated');
		var url = "";
		var data = {};
		if (inserted.length > 0) {
			url = "add";
			data = inserted[0];
		}
		if (updated.length > 0) {
			url = "edit";
			data = updated[0];
		}
		if (url.length<1)
			return;
		$.ajax({
			url : url,
			data : data,
			dataType : 'json',
			success : function(r) {
				if (r && r.success) {
					parent.$.messager.alert('储粮区添加', r.msg); //easyui中的控件messager
					dataGrid.datagrid('acceptChanges');
				} else {
					parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
					dataGrid.datagrid('rejectChanges');
				}
			}
		});
		editrow = 'undefined'; //开关复位
	}

	function deleteFun(nj) {
		if (nj != undefined) {
			dataGrid.datagrid('selectRow', nj);
		}
		var rows = dataGrid.datagrid('getSelections');
		if (rows.length>0) {
			parent.$.messager.confirm('询问', '您是否要删除当前储粮区？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('delete', {
						id : rows[0].id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('操作提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}else
							parent.$.messager.alert('操作提示', result.msg, 'error');
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}

	function editFun(index) {
		if (editrow != 'undefined') {
			dataGrid.datagrid('endEdit', editrow);
		}
		//dataGrid.datagrid('removeEditor',['nj']);
		dataGrid.datagrid('beginEdit', index);
		editrow = index;
	}

	function addFun() {
		if (editrow != 'undefined') {
			dataGrid.datagrid('endEdit', editrow);
		}
		if (editrow == 'undefined') {
			//dataGrid.datagrid('removeEditor',['nj']);
			dataGrid.datagrid('insertRow', {
				index : 0,
				row : {}
			});
			dataGrid.datagrid('beginEdit', 0);
			editrow = 0;
		}
	}

	function saveFun() {
		dataGrid.datagrid('endEdit', editrow); //editrow 为本页面的局部变量
	}

	function cancelFun() {
		editrow = 'undefined'; //开关复位
		dataGrid.datagrid('rejectChanges');
		dataGrid.datagrid('unselectAll');
	}

	// 查询
	function doSearch() {
		// 取得查询条件，发送给后台
		$('#dataGrid').datagrid('load', $.serializeObject($('#serchForm').form())
			
		);
	}
	
	function clearSearch() {
		$('#dataGrid').datagrid('load', {});
		$('#serchForm').find('input').val('');
		$('#serchForm').find('select').val('');
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'west',border:true,split:true"  title="" style="overflow: hidden;">
			<div id="toolbar">
				<form id="serchForm">
					<table>
						<tr><td>名称：</td><td><input type="text" name="fullname" id="fullname"></td><td>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td><td>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
						</tr>
					</table>
				</form>
			</div>
			<table id="dataGrid"></table>
		</div>
		
		<div data-options="region:'east',split:true" style="overflow: hidden;width:600px;">
			<div id="allmap"></div>
		</div>
	</div>
</body>
</html>