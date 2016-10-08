<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>直属库害虫调查总表</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">

	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : 'getList',
			pagination: true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'id', // 主键字段
			columns : [ [ {
				field : 'id',
				title : 'ID',
				width : 40
			},{
				field : 'jsbmc',
				title : '检索表名称',
				width : 120,
				sortable : true,
				align : "center",
			},{
				field : 'modifer',
				title : '录入人',
				width : 60,
				sortable : true,
				align : "center",
			},{
				field : 'modifydate',
				title : '录入日期',
				width : 60,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {
					var d = new Date(value);
					var month = d.getMonth()+1;
					var str = d.getFullYear() + "-" + month + "-" + d.getDate();
					return str;
				},
			},{
				field : 'passaudit',
				title : '审核通过',
				width : 40,
				align : "center",
				sortable :true,
				formatter : function(value, row, index) {if (row!=null) return row.passaudit==true?"是":"否";}
			},{
				field : 'auditor',
				title : '审核人',
				width : 40
			}, {
				field : 'audittime',
				title : '审核时刻',
				width : 60,
			},{
				field : 'auditadvice',
				title : '审核意见',
				width :  200
			},{
				field : 'actor',
				title : '操作',
				align : 'center',
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
			parent.$.messager.confirm('询问', '您是否要删除此检索表 ？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('deleteInsectsIndex', {
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
		openBlank('editTInsectsIndexEntrance',{id:index});
	}

	function addFun() {
		openBlank('addTInsectsIndexEntrance',{} );
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="害虫检索表" style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
		<div id="toolbar" style="display: none;">
		<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		<span>害虫检索表</span>
	</div>
</body>
</html>