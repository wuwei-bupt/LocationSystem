<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
		.datagrid-editable-input { height : 20px; font-size: 16px; }  // 注意覆盖的顺序
</style>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<head>
<title>粮库信息维护</title>
<script >
var detaildg;
var detailEditrow;

$(function() {
	detaildg=$('#detaildg').datagrid({
		url: 'getBins',
		pagination : true,
		fitColumns : true,
		fit : true,
		fitColumns : true,
		rownumbers : true,// 显示行号
		singleSelect : true,// 只能单选
		border : false,
		striped : true,// 隔行变色
		idField : 'lcbm', // 主键字段	
		columns:[[
		          { field : 'lcbm',
		        	  title :  '粮仓编码',
		        	  sortable : true,
		        	  width : 60
		          },
		          {
		        	  field : 'typebin',
		        	  title : '粮仓类型',
		        	 hidden : true,
		        	 width : 60,
		          },{
		        	 field : 'binname',
		        	 title : '仓名',
		        	 width : 60
		          },{
		        	 field : 'contract',
		        	 title : '联系人',
		        	 width : 60
		          }, {
		        	  field : 'orientation',
		        	  title : '朝向',
		        	  sortable : true,
		        	  width : 40
		          }, {
		        	  field : 'granarynum',
		        	  title : '廒间数',
		        	  sortable : true,
		        	  width : 40
		          }, {
		        	  field : 'capacity',
		        	  title : '设计容量',
		        	  sortable : true,
		        	  width : 50
		          },		          {
		        	  field : 'structureofbody',
		        	  title : '仓体结构',
		        	  sortable : true,
		        	  align: 'left',
		        	  width : 80
		          }, {
		        	  field : 'structureofroof',
		        	  title : '顶仓结构',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 80
		          }, {
		        	  field : 'designcapacity',
		        	  title : '单仓容量(T)',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 60
		          },{
		        	  field : 'designgrainheapheight',
		        	  title : '粮堆高度(m)',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 60
		          },{
		        	  field : 'longth',
		        	  title : '长(m)',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 60
		          },{
		        	  field : 'width',
		        	  title : '宽(m)',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 60
		          },{
		        	  field : 'height',
		        	  title : '高(m)',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 60
		          },{
						field : 'actor',
						title : '操作',
						formatter : function(value, row, index) {
							var str = '';
							str += $.formatString(
											'<img onclick="editBin(\'{0}\');" src="{1}" title="编辑"/>',
											row.lcbm,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
							str += '&nbsp;';
							str += $.formatString(
											'<img onclick="deleteBin(\'{0}\');" src="{1}" title="删除"/>',
											index,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
							return str;
						}
					}
		      ]],
		 	toolbar : '#detailtoolbar',
	});
	
});

	function addBin() {
		openBlank('addBinEntrance',{}  );
	}

	function editBin(lcbmcode) {
		openBlank('editBinEntrance',{lcbm:lcbmcode} );
	}
	
	function deleteBin(id) {
		if (id != undefined) {
			detaildg.datagrid('selectRow', id);
		}
		var rows = detaildg.datagrid('getSelections');
		//console.info(rows);
		if (rows.length>0) {
			parent.$.messager.confirm('询问', '您是否要删除当前粮仓？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('deleteBin', {
						lcbm : rows[0].lcbm
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							detaildg.datagrid('reload');
						}else
							parent.$.messager.alert('提示', result.msg, 'error');
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}
	
	
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
   	<div data-options="region:'center' " title="对应粮仓信息"
		style="overflow: hidden; ">
		<table id="detaildg"  ></table>
	</div>
	<div id="detailtoolbar">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:addBin()">添加</a>  
        <a onclick="detaildg.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
   	</div> 

</body>
</html>