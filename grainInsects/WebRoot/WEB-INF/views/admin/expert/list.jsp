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
		
		var expertlist;
		$(function(){
			expertlist = $('#expertlist').datagrid({
			url: 'dataGrid',
			pagination : true,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'username', // 主键字段
			pageSize : 20,
			columns:[[
			          {
						field : 'username',
						title : '用户名',
						width : 100,
						sortable : true,
						align : "center"
					}, {
						field : 'name',
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
						sortable : false,
						align : "center"
					},  {
						field : 'title',
						title : '职称',
						width : 60,
						sortable : false,
						align : "center"
					},  {
						field : 'mobile',
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
											'<img onclick="editExpert(\'{0}\');" src="{1}" title="编辑"/>',
											row.username,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
							str += '&nbsp;';
							str += $.formatString(
											'<img onclick="deleteExpert(\'{0}\');" src="{1}" title="删除"/>',
											index,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
							return str;
						}
						}
			      ]],
			 	toolbar : '#experttoolbar',
			});
			
			expertlist.datagrid('getPager').pagination({    
			    showPageList:true,    
			    buttons:[{    
			        iconCls:'icon-add', 
			        text : '添加',
			        handler:function(){    
			        	addExpert();    
			        }    
			    },{    
			        iconCls:'transmit',
			        text :'刷新',
			        handler:function(){
			        	expertlist.datagrid('reload');  
			        }    
			    }],    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			}); 
		});
		
		// 过滤查询指定信息
		function doSearch(){
			$('#expertlist').datagrid('load', {
				// 参数名与后台pojo属性名一致即可自动填充
				'username': $('#username').val(),
				'name': $('#name').val(),
				'title': $('#title').val()
			});
		}
		function clearSearch(){
			$('#expertlist').datagrid('load',{});
			$('#username').attr('value','');
			$('#name').attr('value','');
			$('#title').attr('value','');
		}
		
		function addExpert(){
			openBlank('addEntrance',{} );
		}
		
		function editExpert(username){
			openBlank('editEntrance', {username:username});  // 这里的username必须和Controller的变量名一致，否则报错
		}
		
		function deleteExpert(id){
			if(id != undefined){
				expertlist.datagrid('selectRow', id);
			}
			var rows = expertlist.datagrid('getSelections');
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
								expertlist.datagrid('reload');
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
     <div data-options="region:'center',split:true" title="专家用户维护列表" style="overflow: hidden; height: 280px; ">
		<table id="expertlist"></table>
     </div>
     <div id="experttoolbar">  
        <table>
        	<tr>
        		<td>用户名:</td>
				<td><input id="username" style="margin-right:2px; border: 1px solid #ccc"/></td>
				<td>真实姓名:</td>
				<td><input id="name" style="margin-right:2px; border: 1px solid #ccc"/></td>
				<td>职称:</td>
				<td><input id="title" style="border: 1px solid #ccc"/></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
			</tr>
        </table>
   	</div>
</body>
</html>