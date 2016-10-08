<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>资源管理</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<style type="text/css">
	.searchbox{
		float : right;
	}
</style>
<script type="text/javascript">
	var treeGrid;
	$(function() {
		treeGrid = $('#treeGrid').treegrid({
			url : 'treeGrid',
			idField : 'id',
			treeField : 'mc',
			//parentField : 'pid',
			fit : true,
			fitColumns : false,
			animate: true,
			collapsible: true,
			pagination: true,
			pageList: [10,20,50,100],
			border : false,
			frozenColumns : [ [ {
				field : 'action',
				title : '操作',
				width : 35,
				formatter : function(value, row, index) {
					var str = '';
					str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="审核"/>', row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
					return str;
				}
			},{
				title : 'ID',
				field : 'id',
				width : 60,
				hidden : true
			} ,{
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
			},
			{
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
				width :  300
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
			}
		});
	});

	function editFun() {
		var node = treeGrid.treegrid('getSelected');
		openBlank('editCatalogIndexEntrance',{id: node.id} );
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
		<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
			<table id="treeGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<a onclick="redo();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_next'">展开</a> 
		<a onclick="undo();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_previous'">折叠</a>
		<a onclick="treeGrid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
	
		<input id="ss" class="easyui-searchbox" style="width:300px;float:right" 
		data-options="searcher:qq,prompt:'Please Input Value',menu:'#mm'"></input> 
		
		<div id="mm" style="width:120px"> 
			<div data-options="name:'bm',iconCls:'icon-ok'">编码</div> 
			<div data-options="name:'mc' ">中文名</div> 
		</div>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="editFun();" data-options="iconCls:'pencil'">审核</div>
	</div>
</body>
</html>