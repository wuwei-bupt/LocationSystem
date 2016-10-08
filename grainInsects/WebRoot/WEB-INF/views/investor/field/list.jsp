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
		var recordlist_field;
		$(function(){
			recordlist_field=$('#recordlist_field').datagrid({
			url: 'getRecordList',
			pagination : true,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'id', // 主键字段	
			columns:[[
			          /* { field : 'id',
			        	  title :  '记录编码',
			        	  sortable : true,
			        	  width : 100
			          }, */ {
			        	  field : 'grainkind',
			        	  title : '粮食名称',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          }, {
			        	  field : 'temperature',
			        	  title : '温度',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          }, {
			        	  field : 'humidity',
			        	  title : '湿度',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          }, {
			        	  field : 'collectdate',
			        	  title : '采集日期',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          },  {
							field : 'actor',
							title : '操作',
							formatter : function(value, row, index) {
								var str = '';
								str += $.formatString(
												'<img onclick="editRecord(\'{0}\');" src="{1}" title="采集记录列表"/>',
												row.id,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
								str += '&nbsp;';
								str += $.formatString(
												'<img onclick="deleteRecord(\'{0}\');" src="{1}" title="删除"/>',
												index,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
								return str;
							}
						}
			      ]],
			 	toolbar : '#record_fieldtoolbar',
			});
			
			recordlist_field.datagrid('getPager').pagination({    
			    showPageList:true,    
			    buttons:[{    
			        iconCls:'icon-add', 
			        text : '添加',
			        handler:function(){    
			        	addRecord();    
			        }    
			    },{    
			        iconCls:'transmit',
			        text :'刷新',
			        handler:function(){
			        	recordlist_field.datagrid('reload');  
			        }    
			    }],    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			});
		});
		
		// 过滤查询指定信息
		function doSearch(){
			$('#recordlist_field').datagrid('load', {
				// 参数名与后台pojo属性名一致即可自动填充
				'grainkind': $('#grainkind').val(),
				'temperature': $('#temperature').val(),
				'collectdate': $('#collectdate').val(),
			});
		}
		function clearSearch(){
			$('#recordlist_field').datagrid('load',{});
			$('#grainkind').attr('value','');
			$('#temperature').attr('value','');
			$('#collectdate').attr('value','');
		}
		function addRecord(){
			openBlank('recordAddEntrance',{} );
		}
		
		function editRecord(id){
			openBlank('recordEditEntrance', {recordId:id});  // 这里的recordId必须和Controller的变量名一致，否则报错
		}
		
		function deleteRecord(id){
			if(id != undefined){
				recordlist_field.datagrid('selectRow', id);
			}
			var rows = recordlist_field.datagrid('getSelections');
			if(rows.length>0){
				parent.$.messager.confirm('询问', '您是否要删除当前采虫记录？', function(b){
					if(b){
						parent.$.messager.progress({
							title: '提示',
							text: '数据处理中，请稍候...'
						});
						$.post('recordDelete', {
							id: rows[0].id
						},function(result){
							if(result.success){
								parent.$.messager.alert('提示',result.msg, 'info');
								recordlist_field.datagrid('reload');
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
   	<div data-options="region:'center',split:true" title="野外记录列表" style="overflow: hidden; height: 280px; ">
		<table id="recordlist_field"></table>
	</div>
	<div id="record_fieldtoolbar">  
   		<table>
			<tr>
				<td>粮食名称:</td>
				<td><input id="grainkind" style="border: 1px solid #ccc"/></td>
				<td>温度:</td>
				<td><input id="temperature" style="margin-right:2px; border: 1px solid #ccc"/></td>
				<td>采集日期:</td>
				<td><input id="collectdate" style="margin-right:2px; border: 1px solid #ccc"/></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
			</tr>
		</table>
   	</div>
</body>
</html>