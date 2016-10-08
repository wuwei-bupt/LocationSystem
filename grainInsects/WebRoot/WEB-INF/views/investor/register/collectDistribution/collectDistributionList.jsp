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
		var collectDistributionList;
		$(function(){
			collectDistributionList=$('#collectDistributionList').datagrid({
			url: 'getDistributionList',
			pagination : true,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'smInsects', // 主键字段	
			columns:[[
			          { field : 'smInsects',
			        	  title :  '昆虫编码',
			        	  sortable : true,
			        	  width : 60
			          }, {
			        	  field : 'name',
			        	  title : '虫种名称',
			        	 width : 60,
			          }, {
							field : 'actor',
							title : '操作',
							formatter : function(value, row, index) {
								var str = '';
								str += $.formatString(
												'<img onclick="editCollectDistribution(\'{0}\');" src="{1}" title="昆虫分布编辑"/>',
												row.smInsects,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
								str += '&nbsp;';
								str += $.formatString(
												'<img onclick="deleteCollectDistribution(\'{0}\');" src="{1}" title="删除"/>',
												index,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
								return str;
							}
						}
			      ]],
			 	toolbar : '#collectDistributionListToolbar',
			});
		});
		
		function addCollectDistribution(){
			openBlank('addCollectDistributionEntrance',{} );
		}
		
		function editCollectDistribution(smInsects){
			openBlank('collectDistributionEditEntrance', {smInsects:smInsects});  // 这里的recordId必须和Controller的变量名一致，否则报错
		}
		
		function deleteCollectDistribution(smInsects){
			if(smInsects != undefined){
				collectDistributionList.datagrid('selectRow', smInsects);
			}
			var rows = collectDistributionList.datagrid('getSelections');
			if(rows.length>0){
				parent.$.messager.confirm('询问', '您是否要删除昆虫分布信息吗？', function(b){
					if(b){
						parent.$.messager.progress({
							title: '提示',
							text: '数据处理中，请稍候...'
						});
						$.post('collectDistributionDelete', {
							smInsects: rows[0].smInsects
						},function(result){
							if(result.success){
								parent.$.messager.alert('提示',result.msg, 'info');
								collectDistributionList.datagrid('reload');
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
   	<div data-options="region:'center',split:true" title="昆虫分布信息列表" style="overflow: hidden; height: 280px; ">
		<table id="collectDistributionList"></table>
	</div>
	<div id="collectDistributionListToolbar">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:addCollectDistribution()">添加</a>  
        <a onclick="collectDistributionList.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
   	</div>
</body>
</html>