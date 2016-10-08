<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<!-- 导入公用配置 -->
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/resources.jsp"%>
<!-- 导入easyui -->
<%@ include file="/common/easyui.jsp"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
	<link type="text/css" href="<%= request.getContextPath() %>/resources/admin/css/crud.css" rel="stylesheet" />
	<style>
		.datagrid-editable-input { height : 20px; font-size: 16px; }  // 注意覆盖的顺序
	</style>
	<script type="text/javascript">
		var investorlist;
		$(function(){
			investorlist=$('#investorlist').datagrid({
			url: 'dataGrid',
			pagination : true,
			pageSize : 20,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'username', // 主键字段	
			columns:[[
			          {
						field : 'username',
						title : '用户名',
						width : 100,
						sortable : true,
						align : "center"
					}, {
						field : 'realname',
						title : '真实姓名',
						width : 100,
						sortable : false,
						align : "center"
					}, {
						field : 'point',
						title : '积分',
						width : 100,
						sortable : false,
						align : "center"
					}, {
						field : 'company',
						title : '单位',
						width : 100,
						sortable : true,
						align : "center"
					},  {
						field : 'title',
						title : '职称',
						width : 60,
						sortable : false,
						align : "center"
					},  {
						field : 'moblie',
						title : '手机',
						width : 80,
						sortable : false,
						align : "center"
					}, {
						field : 'actor',
						title : '操作',
						formatter : function(value, row, index) {
							var str = '';
							str += $.formatString(
											'<img onclick="editInvestor(\'{0}\');" src="{1}" title="编辑"/>',
											row.username,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
							str += '&nbsp;';
							str += $.formatString(
											'<img onclick="deleteInvestor(\'{0}\');" src="{1}" title="删除"/>',
											index,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
							return str;
						}
						}
			      ]],
			 	toolbar : '#investortoolbar',
			});
			
			investorlist.datagrid('getPager').pagination({    
			    showPageList:true,    
			    buttons:[{    
			        iconCls:'icon-add', 
			        text : '添加',
			        handler:function(){    
			        	addInvestor();    
			        }    
			    },{    
			        iconCls:'transmit',
			        text :'刷新',
			        handler:function(){
			        	investorlist.datagrid('reload');  
			        }    
			    }],    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			});  
		});
		
		// 过滤查询指定信息
		function doSearch(){
			$('#investorlist').datagrid('load', {
				// 参数名与后台pojo属性名一致即可自动填充
				'username': $('#username').val(),
				'realname': $('#realname').val(),
				'title': $('#title').val(),
				'company': $('#company').val()
			});
		}
		function clearSearch(){
			$('#investorlist').datagrid('load',{});
			$('#username').attr('value','');
			$('#realname').attr('value','');
			$('#title').attr('value','');
			$('#company').attr('value','');
		}
		
		function addInvestor(){
			openBlank('addEntrance',{} );
		}
		
		function editInvestor(username){
			openBlank('editEntrance', {username:username});  // 这里的username必须和Controller的变量名一致，否则报错
		}
		
		function deleteInvestor(id){
			if(id != undefined){
				investorlist.datagrid('selectRow', id);
			}
			var rows = investorlist.datagrid('getSelections');
			if(rows.length>0){
				parent.$.messager.confirm('询问', '您是否要删除当前用户信息？', function(b){
					if(b){
						parent.$.messager.progress({
							title: '提示',
							text: '数据处理中，请稍候...'
						});
						$.post('remove', {
							username: rows[0].username
						},function(result){
							if(result.success){
								parent.$.messager.alert('提示',result.msg, 'info');
								investorlist.datagrid('reload');
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
     <div data-options="region:'center',split:true" title="虫调用户维护列表" style="overflow: hidden; height: 280px; ">
		<table id="investorlist"></table>
     </div>
     <div id="investortoolbar">  
     	<table>
			<tr>
				<td>用户名:</td>
				<td><input id="username" style="margin-right:2px; border: 1px solid #ccc"/></td>
				<td>真实姓名:</td>
				<td><input id="realname" style="margin-right:2px; border: 1px solid #ccc"/></td>
				<td>单位:</td>
				<td><input id="company" style="margin-right:2px; border: 1px solid #ccc"/></td>
				<td>职称:</td>
				<td><input id="title" style="border: 1px solid #ccc"/></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
			</tr>
		</table>
   	</div>
</body>
</html>