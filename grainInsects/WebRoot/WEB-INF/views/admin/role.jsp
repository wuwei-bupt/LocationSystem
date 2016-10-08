<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html>
<head>
<title>角色管理</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">
	var dataGrid;
	$(function() {
		editrow='undefined';			//行编辑开关
		dataGrid = $('#dataGrid').datagrid({
			url : 'dataGrid',
			pagination: true,
			pageSize : 20,
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
				//hidden:true
			}, {
				field : 'name',
				title : '角色名称',
				width : 80,
				sortable : true,
				align : "center",
				editor:{
					type : 'validatebox',
					options:{
						required : true
					}
				}
			}, {
				field : 'isSystem',
				title : '系统角色',
				width : 60,
				sortable : true,
				align : "center",
				editor:{
					type : 'validatebox',
					options:{
						required : true
					}
				}
			}, {
				field : 'description',
				title : '角色描述',
				width : 180,
				sortable : true,
				align : "center",
				editor:{
					type : 'text'
				}
			},{
				field : 'actor',
				title : '操作',
				width : 170,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/>',index, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
					str += '&nbsp;';
						str += $.formatString('<img onclick="grantFun(\'{0}\');" src="{1}" title="授权"/>',row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/key.png');
					str += '&nbsp;';
						str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/>',index, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
					return str;
				}
			} ] ],
			toolbar : '#toolbar',

			onLoadSuccess : function() {
				parent.$.messager.progress('close');

				$(this).datagrid('tooltip');
			},
			onAfterEdit : function(rowIndex, rowData, changes){
				//console.info(rowData);
				afterEdit(rowIndex, rowData, changes);
			}
		});
	});


	function afterEdit(rowIndex, rowData, changes) {
		var inserted = dataGrid.datagrid('getChanges', 'inserted');
		var updated = dataGrid.datagrid('getChanges', 'updated');
		var url = "";
		var data={};
		if (inserted.length > 0){
			url = "add";
			data=inserted[0];
		}
		if (updated.length > 0){
			url = "edit";
			data = updated[0];
	}
		console.info(url);
		$.ajax({
			url: url,
			data:data,
			dataType:'json',
			success:function(r){
				if (r && r.success){
					parent.$.messager.alert('title',r.msg);	//easyui中的控件messager
					dataGrid.datagrid('acceptChanges');
				}else{
					parent.$.messager.alert('数据更新或插入','任务失败！','error');	//easyui中的控件messager
					dataGrid.datagrid('rejectChanges');
				}
			}
		});
		editrow = 'undefined'; //开关复位
	}

	function deleteFun(id) {
		//console.info(id);
		if (id != undefined) {
			dataGrid.datagrid('selectRow', id);
		}
		var rows = dataGrid.datagrid('getSelections');
		//console.info(rows);
		if (rows.length>0) {
			parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('delete', {
						id : rows[0].id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
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
		dataGrid.datagrid('beginEdit', index);
		editrow = index;
	}

	function addFun() {
		if (editrow != 'undefined') {
			dataGrid.datagrid('endEdit', editrow);
		}
		if (editrow == 'undefined') {
			dataGrid.datagrid('insertRow', {
				index : 0,
				row : {}
			});
			dataGrid.datagrid('beginEdit', 0);
			editrow = 0;
		}
	}

	function saveFun() {
		//console.info(editrow);
		dataGrid.datagrid('endEdit', editrow); //editrow 为本页面的局部变量
	}

	function cancelFun() {
		editrow = 'undefined'; //开关复位
		dataGrid.datagrid('rejectChanges');
		dataGrid.datagrid('unselectAll');
	}

	function grantFun(id) {
		if (id != undefined) {
		
			parent.$.modalDialog({
				title : '角色授权',
				width : 500,
				height : 600,
				href : 'admin/role/grantPage?id=' + id,
				buttons : [ {
					text : '授权',
					handler : function() {
						//parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
						var f = parent.$.modalDialog.handler.find('#form');
						f.submit();
					}
				} ]
			});
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		<a onclick="cancelFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-redo'">撤销</a> 
		<a onclick="saveFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-save'">保存</a> 
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
	</div>

</body>
</html>