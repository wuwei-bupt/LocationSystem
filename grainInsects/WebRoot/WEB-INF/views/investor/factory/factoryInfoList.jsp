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
		var factorylist;
		var smFactoryvar;
	
		$(function() {
			factorylist=$('#factorylist').datagrid({
			url: 'getFactoryList',
			pagination : true,
			fitColumns : true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'smFactory', // 主键字段	
			columns:[[
			          { field : 'smFactory',
			        	  title :  '加工厂编码',
			        	  sortable : true,
			        	  width : 95
			          },
			          {
			        	  field : 'nameFactory',
			        	  title : '加工厂名称',
			        	 //hidden : true,
			        	 width : 100,
			          },{
			        	  field : 'contacts',
			        	  title : '联系人',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 40
			          },{
			        	  field : 'phone',
			        	  title : '联系电话',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 50
			          }, {
			        	  field : 'address',
			        	  title : '详细地址',
			        	  sortable : true,
			        	  width : 100
			          }, {
			        	  field : 'constructiondate',
			        	  title : '建厂日期',
			        	  sortable : true,
			        	  align: 'left',
			        	  width : 45
			          }, {
			        	  field : 'annualpurchase',
			        	  title : '年收购量',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 40
			          }, {
			        	  field : 'majorkindofpurchase',
			        	  title : '主要收购粮种',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 60
			          },{
			        	  field : 'postcode',
			        	  title : '邮编',
			        	  align: 'center',
			        	  sortable : true,
			        	  width : 35
			          },{
							field : 'actor',
							title : '操作',
							formatter : function(value, row, index) {
								var str = '';
								str += $.formatString(
												'<img onclick="editFactory(\'{0}\');" src="{1}" title="编辑"/>',
												row.smFactory,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
								str += '&nbsp;';
								str += $.formatString(
												'<img onclick="deleteFactory(\'{0}\');" src="{1}" title="删除"/>',
												index,
												'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
								return str;
							}
						}
			      ]],
			 	toolbar : '#factorytoolbar',
			});
			
			factorylist.datagrid('getPager').pagination({    
			    showPageList:true,    
			    buttons:[{    
			        iconCls:'icon-add', 
			        text : '添加',
			        handler:function(){    
			        	addFactory();    
			        }    
			    },{    
			        iconCls:'transmit',
			        text :'刷新',
			        handler:function(){
			        	factorylist.datagrid('reload');  
			        }    
			    }],    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			});
		});
		// 过滤查询指定信息
		function doSearch(){
			$('#factorylist').datagrid('load', {
				// 参数名与后台pojo属性名一致即可自动填充
				'nameFactory': $('#nameFactory').val(),
				'contacts': $('#contacts').val(),
				'phone': $('#phone').val(),
				'majorkindofpurchase': $('#majorkindofpurchase').val(),
			});
		}
		function clearSearch(){
			$('#factorylist').datagrid('load',{});
			$('#nameFactory').attr('value','');
			$('#contacts').attr('value','');
			$('#phone').attr('value','');
			$('#majorkindofpurchase').attr('value','');
		}

		function addFactory() {
			openBlank('factoryAddEntrance',{}  );
		}
	
		function editFactory(smFactory) {
			openBlank('editFactoryEntrance',{smFactory:smFactory });
		}
		
		function deleteFactory(smFactory){
			if (smFactory != undefined) {
				factorylist.datagrid('selectRow', smFactory);
			}
			var rows = factorylist.datagrid('getSelections');
			if (rows.length>0) {
				parent.$.messager.confirm('询问', '您是否要删除当前工厂信息吗？', function(b) {
					if (b) {
						parent.$.messager.progress({
							title : '提示',
							text : '数据处理中，请稍后....'
						});
						$.post('factoryDelete', {
							smFactory : rows[0].smFactory
						}, function(result) {
							if (result.success) {
								parent.$.messager.alert('提示', result.msg, 'info');
								factorylist.datagrid('reload');
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
   	<div data-options="region:'center',split:true" title="加工厂列表" style="overflow: hidden; height: 280px; ">
		<table id="factorylist"></table>
	</div>
	<div id="factorytoolbar">  
		<table>
			<tr>
				<td>加工厂名称:</td>
				<td><input id="nameFactory" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td>联系人:</td>
				<td><input id="contacts" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td>联系电话:</td>
				<td><input id="phone" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td>主要收购粮种:</td>
				<td><input id="majorkindofpurchase" style="margin-right:5px; border: 1px solid #ccc"/></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
			</tr>
		</table>
   	</div>
</body>
</html>