<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>磷化氢熏蒸储粮害虫防治效果调查汇总表</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">

	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : 'dataGrid',//数据获取地址
			pagination: true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'id', // 主键字段
			columns : [ [ 
			 {
				field : 'topic',
				title : '主题',
				width : 200,
				align : "center",
			},{
				sortable:true,
				field : 'optype',
				title : '类型',
				width : 100,
				align : "center",
				formatter : function(value, row, index) {
					var table = ['害虫识别', '害虫防治', '其他'];
					return table[value];	
				}
			},{
				field : 'expert.name',
				title : '专家',
				width : 100,
				align : "center"
			},{
				sortable:true,
				field : 'createdate',
				title : '创建时间',
				width : 100,
				align : "center"
			},{
				field : 'actor',
				title : '操作',
				width : 40,
				formatter : function(value, row, index) {
					var str = '';
					str += $.formatString('<img onclick="detailFun(\'{0}\');" src="{1}" title="查看"/> ',row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/eye.png');
					return str;
				}
			}
			] ],
			toolbar : '#toolbar',
		});
		
	});


	function detailFun(index) {
		openBlank('getIdea',{id:index});
	}
	
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="专家意见" style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
		<div id="toolbar" style="display: none;">
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		<span>意见列表</span>
	</div>
</body>
</html>