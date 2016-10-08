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
		var depotlist;
		var binlist;
		var recordlist;
		var lcbmvar;
		var lkbmvar;
		
		$(function() {
		
			depotlist=$('#depotlist').datagrid({
			url: 'getDepotList',
			pagination : true,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'lkbm', // 主键字段	
			columns:[[
			          { field : 'lkbm',
			        	  title :  '粮库编码',
			        	  sortable : true,
			        	  width : 60
			          },
			          {
			        	  field : 'lkmc',
			        	  title : '粮库名称',
			        	 width : 60,
			          }, {
			        	  field : 'lkdz',
			        	  title : '粮库地址',
			        	  sortable : true,
			        	  width : 100
			          }, {
			        	  field : 'contact',
			        	  title : '联系人',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 40
			          }, {
			        	  field : 'phone',
			        	  title : '手机',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          }
			      ]],
			 	toolbar : '#depottoolbar',
			 	onClickRow : function(rowIndex, rowData){
		        	  depotlist.datagrid('unselectAll');
		        	  depotlist.datagrid('selectRow', rowIndex);
		        	  binlist.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
		        	  binlist.datagrid({
		        		  url : 'getBinList',
		        		  queryParams:{ lkbm : rowData.lkbm },
		        		  title: rowData.lkbm + "--" + rowData.lkmc + "&nbsp;粮仓列表"
		        	  });
		        	 lkbmvar=rowData.lkbm;
		          },
		          onLoadSuccess: function(data){
						if (data.rows.length>0){
							depotlist.datagrid('selectRow', 0);
							binlist.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
							binlist.datagrid({
				        		  url : 'getBinList',
				        		  queryParams:{ lkbm : data.rows[0].lkbm},
				        		  title: data.rows[0].lkbm + "--" + data.rows[0].lkmc + "&nbsp;粮仓列表"
				        	  });
				        	 lkbmvar=data.rows[0].lkbm;
						}else{
							binlist.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
						}
					}
			});
			depotlist.datagrid('getPager').pagination({    
			    showPageList:true,  
			    buttons:[{    
			        iconCls:'transmit',
			        text :'刷新',
			        handler:function(){
			        	depotlist.datagrid('reload');  
			        }    
			    }],    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			});
		
		
			binlist=$('#binlist').datagrid({
			url: 'getBinList',
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
			        	  title : '仓型',
			        	 width : 50,
			          },
			          {
			        	 field : 'binname',
			        	 title : '仓名',
			        	 width : 60
			          },
			           {
			        	  field : 'orientation',
			        	  title : '朝向',
			        	  sortable : true,
			        	  width : 40
			          }, {
			        	  field : 'granarynum',
			        	  title : '廒间数',
			        	  sortable : true,
			        	  width : 40
			          },
			           {
			        	  field : 'structureofbody',
			        	  title : '仓体结构',
			        	  sortable : true,
			        	  align: 'left',
			        	  width : 50
			          }, {
			        	  field : 'structureofroof',
			        	  title : '顶仓结构',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 50
			          }, {
			        	  field : 'designcapacity',
			        	  title : '设计单仓容量',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          },{
			        	  field : 'circulatedevice',
			        	  title : '环流装置',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          }
			      ]],
			 	toolbar : '#bintoolbar',
			 	onClickRow : function(rowIndex, rowData){
		        	  binlist.datagrid('unselectAll');
		        	  binlist.datagrid('selectRow', rowIndex);
		        	  recordlist.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
		        	  recordlist.datagrid({
		        		  url : 'recordList',
		        		  queryParams:{ lcbm : rowData.lcbm },
		        		  title: rowData.lcbm + "--" + rowData.typebin + "&nbsp;记录列表"
		        	  });
		        	 lcbmvar=rowData.lcbm;
		          },
		          onLoadSuccess: function(data){
						if (data.rows.length>0){
							binlist.datagrid('selectRow', 0);
							recordlist.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
							recordlist.datagrid({
				        		  url : 'recordList',
				        		  queryParams:{ lcbm : data.rows[0].lcbm},
				        		  title: data.rows[0].lcbm + "--" + data.rows[0].typebin + "&nbsp;记录列表"
				        	  });
				        	 lcbmvar=data.rows[0].lcbm;
						}else{
							recordlist.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
						}
					}
			});
			
			recordlist=$('#recordlist').datagrid({
			pagination : true,
			fitColumns : true,
			fit : true,
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
			        	  width : 100
			          },
			          {
			        	  field : 'collector',
			        	  title : '采集者',
			        	 hidden : true,
			        	 width : 60
			          }, {
			        	  field : 'mobile',
			        	  title : '手机',
			        	  sortable : true,
			        	  width : 60
			          },		          {
			        	  field : 'companyCollector',
			        	  title : '采集人员单位',
			        	  sortable : true,
			        	  align: 'left',
			        	  width : 90
			          }, {
			        	  field : 'dateCollection',
			        	  title : '采集日期',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 50
			          },{
							field : 'actor',
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
		});
		
		
		// 过滤查询指定信息
		function doSearch(){
			$('#depotlist').datagrid('load', {
				// 参数名与后台pojo属性名一致即可自动填充
				'lkbm': $('#lkbm').val(),
				'lkmc': $('#lkmc').val(),
				'contact': $('#contact').val()
			});
		}
		function clearSearch(){
			$('#depotlist').datagrid('load',{});
			$('#lkbm').attr('value','');
			$('#lkmc').attr('value','');
			$('#contact').attr('value','');
		}
		
		function addRecord(){
			var rows = binlist.datagrid("getSelections");
			if(rows.length<=0){
				parent.$.messager.alert('提示', '没有选择粮库，不能添加记录', 'info');
				return;
			}
			openBlank('recordAddEntrance',{lcbm:rows[0].lcbm } );
		}
		
		function editRecord(smCollection) {
			var rows = binlist.datagrid("getSelections");
			if(rows.length<=0){
				parent.$.messager.alert('提示', '没有选择粮库，不能编辑记录', 'info');
				return;
			}
			openBlank('recordEditEntrance',{smCollection:smCollection, lcbm:rows[0].lcbm}/* , 'editBin'  */);
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
	<div data-options="region:'center',split:true" 
			style="overflow: hidden; ">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true" title="粮库列表" style="overflow: hidden; height: 280px; ">
				<table id="depotlist"></table>
			</div>
			<div id="depottoolbar">
				<table>
					<tr>
						<td>粮库编码:</td>
						<td><input id="lkbm" style="margin-right:2px; border: 1px solid #ccc"/></td>
						<td>粮库名称:</td>
						<td><input id="lkmc" style="margin-right:2px; border: 1px solid #ccc"/></td>
						<td>联系人:</td>
						<td><input id="contact" style="border: 1px solid #ccc; width: 100px;"/></td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
				</table>
		   	</div>
		   	<div data-options="region:'center',split:true" style="overflow: hidden; height: 280px; ">
				<table id="binlist"></table>
			</div>
			<div id="bintoolbar">  
		        <a onclick="binlist.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		   	</div> 
	   	</div>
   	</div>
   	<div data-options="region:'east',split:true" style="overflow: hidden; width: 410px; ">
		<table id="recordlist"></table>
	</div>
	<div id="recordtoolbar">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:addRecord()">添加</a>  
        <a onclick="recordlist.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
   	</div>
</body>
</html>