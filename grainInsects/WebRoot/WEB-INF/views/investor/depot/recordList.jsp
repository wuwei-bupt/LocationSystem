<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
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
		var recordlist;
		$(function() {
			recordlist=$('#recordlist').datagrid({
			url: "getRecordList",
			pagination : true,
			fit : true,
			async: false,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'smCollection', // 主键字段	
			columns:[[
			          { field : 'smCollection',
			        	  title :  '记录编码',
			        	  sortable : true,
			        	  width : 100,
			          },{
			        	  field : 'tgrainbin',
			        	  title : '粮仓名',
			        	  align: 'center',
			        	  /* sortable : true, */
			        	  width : 60,
			        	  formatter: function(value, row, index){
			        	  	return value.binname;
			        	  },
			          }/*, {
			        	  field : 'tgrainbin',
			        	  title : '粮仓编码',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 100,
			        	  formatter: function(value, row, index){
			        	  	console.log(row);
			        	  	return value.lcbm;
			        	  },
			          },{
			        	  field : 'tgrainbin',
			        	  title : '粮仓联系人',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 80,
			        	  formatter: function(value, row, index){
			        	  	return value.contract;
			        	  },
			          } */, {
			        	  field : 'dateCollection',
			        	  title : '采集日期',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 100,
			          }, {
			        	  field : 'modifydate',
			        	  title : '修改日期',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 100,
			          }, {
							field : 'actors',
							title : '操作',
							formatter : function(value, row, index) {
								var str = '';
								str += $.formatString(
												'<img onclick="editRecord(\'{0}\');" src="{1}" title="编辑"/>',
												row.smCollection,
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
			 	toolbar : '#recordtoolbar',
			});
			recordlist.datagrid('getPager').pagination({    
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
			        	recordlist.datagrid('reload');  
			        }
			    }],    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			});
		});
		
		
		// 过滤查询指定信息
		function doSearch(){
			$('#recordlist').datagrid('load', {
				// 参数名与后台pojo属性名一致即可自动填充
				/* 'mobile': $('#mobile').val(), */
				/* 'tgrainbin.lcbm': $('#TGrainbinName').val(), */
				'dateCollection': $('#dateCollection').val(),
				'modifydate': $('#modifydate').val()
			});
		}
		function clearSearch(){
			$('#recordlist').datagrid('load',{});
			/* $('#TGrainbinName').attr('value',''); */
			$('#dateCollection').attr('value','');
			$('#modifydate').attr('value','');
		}
		
		function addRecord(){
			openBlank('recordAddEntrance',{ } );
		}
		
		function editRecord(smCollection) {
			openBlank('recordEditEntrance',{smCollection:smCollection}/* , 'editBin'  */);
		}
		
		function deleteRecord(smCollection) {
			if (smCollection != undefined) {
				recordlist.datagrid('selectRow', smCollection);
			}
			var rows = recordlist.datagrid('getSelections');
			if (rows.length>0) {
				parent.$.messager.confirm('询问', '您是否要删除当前采虫记录？', function(b) {
					if (b) {
						parent.$.messager.progress({
							title : '提示',
							text : '数据处理中，请稍后....'
						});
						$.post('recordDelete', {
							smCollection : rows[0].smCollection
						}, function(result) {
							if (result.success) {
								parent.$.messager.alert('提示', result.msg, 'info');
								recordlist.datagrid('reload');
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
   	<div data-options="region:'center',split:true" style="overflow: hidden;">
		<table id="recordlist"></table>
	</div>
	<div id="recordtoolbar">
		<table>
			<tr>
				<!-- <td>粮仓名:</td>
				<td><input id="TGrainbinName" style="margin-right:5px; border: 1px solid #ccc"/></td> -->
				<td>采集日期:</td>
				<td><input id="dateCollection" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td>修改日期:</td>
				<td><input id="modifydate" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
			</tr>
		</table>
	</div>
</body>
</html>