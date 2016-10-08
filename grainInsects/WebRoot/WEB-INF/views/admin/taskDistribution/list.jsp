<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>任务分配</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/easyUI/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/datePicker/WdatePicker.js"></script>

<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/ztree/css/zTreeStyle.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.searchbox{
		float : right;
	}
</style>
<script type="text/javascript">
	var treeGrid;
	$(function() {
	
		$('#expert').combobox({
			url: "getExperts",
			valueField:'value',
		    textField:'text',
		});
		
		treeGrid = $('#catalogIndexTreeGrid').treegrid({
			url : 'getCatalogIndexs',
			idField : 'id',
			treeField : 'mc',
			//parentField : 'pid',
			fit : true,
			fitColumns : false,
			animate: true,
			collapsible: true,
			pagination: true,
			autoHeight : false, 
			pageList: [2,5,10,20,50,100],
			border : false,
			frozenColumns : [ [ /* {
				field : 'action',
				title : '操作',
				width : 50,
				formatter : function(value, row, index) {
					var str = '';
					str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/>', row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
					str += '&nbsp;';
					str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/>', row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
					return str;
				}
			}, */
			{field:'id',checkbox:true}, 
			/* {
				title : 'ID',
				field : 'id',
				width : 60,
				hidden : true
			} , */{
				title : 'PID',
				field : 'pid',
				width : 60,
				hidden : true
			} ,{
				field : 'mc',
				title : '名称',
				width : 180
			},{
				field : 'flm',
				title : '分类名',
				width : 100
			},{
				field : 'bm',
				title : '编码',
				width : 180
			},
			] ],
			columns : [ [  {
				field : 'ywm',
				title : '英文名',
				width : 180
			},{
				field : 'ymc',
				title : '拉丁学名',
				width : 200
			}, {
				field : 'zylb',
				title : '重要储藏害虫类别',
				width : 120,
			}, {
				field : 'source',
				title : '资料来源',
				width : 180
			},{
				field : 'passaudit',
				title : '审核通过',
				width : 80,
				align : "center",
				sortable :true,
				formatter : function(value, row, index) {if (row!=null) return row.passaudit==true?"是":"否";}
			},{
				field : 'auditor',
				title : '审核人',
				width : 80
			}, {
				field : 'audittime',
				title : '审核时刻',
				width : 120,
			},{
				field : 'auditadvice',
				title : '审核意见',
				width :  400
			}
			] ],
			toolbar : '#toolbar',
			onContextMenu : function(e, row) {
				e.preventDefault();
				$(this).treegrid('unselectAll');
				$(this).treegrid('select', row.id);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onLoadSuccess : function() {
				parent.$.messager.progress('close');
				$(this).treegrid('tooltip');
				$(this).treegrid('unselectAll');
				
			},
			onBeforeLoad : function(row, param){
				if(row == null)
					param.id = null;
			} 
	});
    });

	function deleteFun(id) {
		if (id != undefined) {
			treeGrid.treegrid('select', id);
		}
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			parent.$.messager.confirm('询问', '您是否要删除当前资源？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${pageContext.request.contextPath}/admin/catalogIndex/delete', {
						id : node.id
					}, function(result) {
					
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							treeGrid.treegrid('reload');
							parent.layout_west_tree.tree('reload');
							parent.$.messager.progress('close');
						}else
							parent.$.messager.alert('提示', result.msg, 'error');
							parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}

	function editFun() {
		var node = treeGrid.treegrid('getSelected');
		openBlank('editCatalogIndexEntrance',{id: node.id} );
	}

	function addFun() {
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			openBlank('addCatalogIndexEntrance',{id:node.id, mc:node.mc} );	//增加子节点
		}else{
			openBlank('addCatalogIndexEntrance',{id:'' } );	//增加根节点
		}
	}

	function redo() {
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			treeGrid.treegrid('expandAll', node.id);
		} else {
			treeGrid.treegrid('expandAll');
		}
	}

	function undo() {
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			treeGrid.treegrid('collapseAll', node.id);
		} else {
			treeGrid.treegrid('collapseAll');
		}
	}
	
	function qq(value,name){ 
		//console.info(value+":"+name) ;
		if (name=='mc')
			treeGrid.treegrid('load',{mc:value});
		if (name=='bm')
			treeGrid.treegrid('load',{bm:value});
	} 

</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="知识库  > 任务分配 " style="overflow: hidden;">
			<form id="inputForm" method="post" enctype="multipart/form-data">
				<ul id="tab" class="tab">
					<li>
						<input type="button" value="虫种类别" id="catalogIndexs"/>
					</li>
					<li>
						<input type="button" value="检索表" id="insectsIndexs" />
					</li>
				</ul>
			</form>
			<table id="catalogIndexTreeGrid"></table>
			<table id="insectsIndexTreeGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		
		专家列表：<input id="expert" name="expert">&nbsp;&nbsp;&nbsp;
		完成时刻：<input type="text" name="deadLine" class="text Wdate" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'});" />&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="distributeTask()" iconCls="icon-save">分配任务</a>
		<!-- <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		<a onclick="redo();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_next'">展开</a> 
		<a onclick="undo();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_previous'">折叠</a>
		<a onclick="treeGrid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
	
		<input id="ss" class="easyui-searchbox" style="width:300px;float:right" 
		data-options="searcher:qq,prompt:'Please Input Value',menu:'#mm'"></input> 
		
		<div id="mm" style="width:120px"> 
			<div data-options="name:'bm',iconCls:'icon-ok'">编码</div> 
			<div data-options="name:'mc' ">中文名</div> 
		</div> -->
	</div>

	<!-- <div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div>
		<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
		<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
	</div> -->
</body>
</html>