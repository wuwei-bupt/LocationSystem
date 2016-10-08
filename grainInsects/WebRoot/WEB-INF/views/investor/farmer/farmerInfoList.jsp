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
		.datagrid-editable-input { height : 20px; font-size: 16px; }  // 注意覆盖的顺序
	</style>
	<script type="text/javascript">
		var farmerlist;
		$(function() {
			farmerlist=$('#farmerlist').datagrid({
			url: 'getFarmerInfoList',
			pagination : true,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'smFarmer', // 主键字段
			columns:[[
			          { field : 'smFarmer',
			        	  title :  '农户编码',
			        	  sortable : true,
			        	  width : 100
			          },
			          {
			        	  field : 'nameFamer',
			        	  title : '户主姓名',
			        	 //hidden : true,
			        	 width : 60,
			          }, {
			        	  field : 'address',
			        	  title : '地址',
			        	  sortable : true,
			        	  width : 90
			          }, {
			        	  field : 'postcode',
			        	  title : '邮编',
			        	  sortable : true,
			        	  align: 'left',
			        	  width : 50
			          }, {
			        	  field : 'phone',
			        	  title : '手机号',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 80
			          }, {
			        	  field : 'population',
			        	  title : '人口',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 20
			          },{
			        	  field : 'economic',
			        	  title : '经济状况',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 40
			          },{
			        	  field : 'traffic',
			        	  title : '交通状况',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 40
			          },{
			        	  field : 'geography',
			        	  title : '地理环境',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          },{
							field : 'actor',
							title : '操作',
							formatter : function(value, row, index) {
								var str = '';
								str += $.formatString(
												'<img onclick="editFarmer(\'{0}\');" src="{1}" title="编辑"/>',
												row.smFarmer,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
								str += '&nbsp;';
								str += $.formatString(
												'<img onclick="deleteFarmer(\'{0}\');" src="{1}" title="删除"/>',
												index,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
								return str;
							}
						}
			      ]],
			 	toolbar : '#farmertoolbar',
			});
			farmerlist.datagrid('getPager').pagination({    
			    showPageList:true,    
			    buttons:[{    
			        iconCls:'icon-add', 
			        text : '添加',
			        handler:function(){    
			        	addFarmer();    
			        }    
			    },{    
			        iconCls:'transmit',
			        text :'刷新',
			        handler:function(){
			        	farmerlist.datagrid('reload');  
			        }    
			    }],    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			});   
	});
	// 过滤查询指定信息
	function doSearch(){
		$('#farmerlist').datagrid('load', {
			// 参数名与后台pojo属性名一致即可自动填充
			'nameFamer': $('#nameFamer').val(),
			'address': $('#address').val(),
			'phone': $('#phone').val(),
			'geography': $('#geography').val(),
		});
	}
	function clearSearch(){
		$('#farmerlist').datagrid('load',{});
		$('#address').attr('value','');
		$('#nameFamer').attr('value','');
		$('#phone').attr('value','');
		$('#geography').attr('value','');
	}
	function addFarmer() {
		openBlank('farmerAdd',{}  );
	}

	function editFarmer(smFarmer) {
		openBlank('farmerEditEntrance',{smFarmer:smFarmer} );
	}
	
	function deleteFarmer(smFarmer){
		if (smFarmer != undefined) {
			farmerlist.datagrid('selectRow', smFarmer);
		}
		var rows = farmerlist.datagrid('getSelections');
		//console.info(rows.length);
		if (rows.length>0) {
			parent.$.messager.confirm('询问', '您是否要删除当前农户吗？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('farmerDelete', {
						smFarmer : rows[0].smFarmer
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							farmerlist.datagrid('reload');
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
   	<div data-options="region:'center',split:true" title="农户列表" style="overflow: hidden; height: 280px; ">
		<table id="farmerlist"></table>
	</div>
	<div id="farmertoolbar">
		<table>
			<tr>
				<td>户主姓名:</td>
				<td><input id="nameFamer" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td>地址:</td>
				<td><input id="address" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td>手机号:</td>
				<td><input id="phone" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td>地理环境:</td>
				<td><input id="geography" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
			</tr>
		</table>
	</div>
</body>
</html>