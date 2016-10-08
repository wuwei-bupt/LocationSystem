<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title> 防虫线防治效果调查汇总表</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">

	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : 'dataGrid',             //？？？？？
			pagination: true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'id', // 主键字段
			columns : [ [ {
				field : 'id',          //？？？？？
				title : 'ID',
				width : 40
			},
			 {
				field : 'annual',          //？？？？？
				title : '年度',
				width : 50,
				sortable : true,
				align : "center",
			},{
				field : 'reporter',          //？？？？？
				title : '填表人',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'reportdate',          //？？？？？
				title : '填表日期',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'graindepot',
				title : '所属库',
				width : 60,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (value!=null) return value.lkmc;	},
			},{
				field : 'actor',          
				title : '操作',
				width : 40,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="修改"/> ',row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
					str += '&nbsp;';
						str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/> ',row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
		});
		
	});

	function deleteFun(id) {               
		if (id!=null){
			parent.$.messager.confirm('询问', '您是否要删除当前上报记录 ？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('deleteReportRec', {          
						id : id               
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}else
							parent.$.messager.alert('提示', result.msg, 'error');
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}

	function editFun(index) {         
		openBlank('editDepotFlylineEntrance',{id:index});         
	}

	function addFun() {
		openBlank('addDepotFlylineEntrance',{ } );        
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="数据上报  > 防虫线杀虫总表 " style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
		<div id="toolbar" style="display: none;">
		<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		<span>防虫线防治效果调查汇总表</span>
	</div>
</body>
</html>