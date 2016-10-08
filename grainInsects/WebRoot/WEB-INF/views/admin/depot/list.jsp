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
var depotdg;
var detaildg;
var areadg;
var depotEditrow;		//控制编辑的变量
var detailEditrow;
var lkbmvar;				//粮库编码

$(function() {
	depotEditrow='undefined';			//行编辑开关
	detailEditrow='undefined';			//行编辑开关
	
	depotdg=$('#depotdg').datagrid({
		url : 'getDepot',
		pagination : true,
		fitColumns : true,
		async: false,
		//pagePosition :'top',
		fit : true,
		rownumbers : true,// 显示行号
		singleSelect : true,// 只能单选
		border : false,
		striped : true,// 隔行变色
		idField : 'lkbm', // 主键字段
		columns:[[
		          { field : 'lkbm',
		        	  title :  '粮库编码',
		        	  sortable : true,
		        	  width: 60,
		          },{ field : 'lkmc',
		        	  title :  '粮库名称',
		        	  sortable : true,
		        	  width: 100,
		          },{ field : 'area',
		        	  title :  '所在地区',
		        	  sortable : true,
		        	  width: 80,
		        	  formatter : function(value, row, index) {  
		        		  return value.name;
		        	  }
		          },{ field : 'lkdz',
		        	  title :  '粮库地址',
		        	  sortable : true,
		        	  width: 200,
		          },{ field : 'postcode',
		        	  title :  '邮编',
		        	  sortable : true,
		        	  width: 60,
		          },{ field : 'contact',
		        	  title :  '联系人',
		        	  sortable : true,
		        	  width: 60,
		          },{ field : 'phone',
		        	  title :  '手机',
		        	  sortable : true,
		        	  width: 60,
		          },{ field : 'longtitude',
		        	  title :  '经度',
		        	  sortable : true,
		        	  width: 70,
		          },{ field : 'latitude',
		        	  title :  '纬度',
		        	  sortable : true,
		        	  width: 70,
		          },{ field : 'altitude',
		        	  title :  '高程',
		        	  sortable : true,
		        	  width: 60,
		          },{ field : 'totalbin',
		        	  title :  '粮仓数',
		        	  sortable : true,
		        	  width: 50,
		          },{ field : 'hasreal',
		        	  title :  '实时采集',
		        	  sortable : true,
		        	  align: 'center',
		        	  width: 50,
			        	styler: function(value,row,index){
	                               if (value=='1')
	                                    return  'background-color:#00ee00;color:red;';
	                            },
	                    formatter : function(value, row, index) {  
	                    	if (value=='0') return '否';
	                    	if (value=='1') return '是';
	                    },
		          },
					{	field : 'actor',
						title : '操作',
						formatter : function(value, row, index) {
							var str = '';
							str += $.formatString(
											'<img onclick="editDepot(\'{0}\',\'{1}\');" src="{2}" title="编辑"/>',
											index,row.lkbm,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
							str += '&nbsp;';
							str += $.formatString(
											'<img onclick="deleteDepot(\'{0}\');" src="{1}" title="删除"/>',
											index,
											'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
							return str;
						}
					}
		          ]],
		          toolbar : '#toolbar',
		          onClickRow : function(rowIndex, rowData){
		        	  depotdg.datagrid('unselectAll');
		        	  depotdg.datagrid('selectRow', rowIndex);
		        	  detaildg.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
		        	  detaildg.datagrid({
		        		  url : 'getBins',
		        		  queryParams:{ lkbm : rowData.lkbm}
		        	  });
		        	 lkbmvar=rowData.lkbm;
		          },
				onLoadSuccess: function(data){
					if (data.rows.length>0){
						depotdg.datagrid('selectRow', 0);
						detaildg.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
						detaildg.datagrid({
			        		  url : 'getBins',
			        		  queryParams:{ lkbm : data.rows[0].lkbm}
			        	  });
			        	 lkbmvar=data.rows[0].lkbm;
					}else{
						detaildg.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
					}
				}
		   }
	);
	// 设置自定义分页栏
	depotdg.datagrid('getPager').pagination({    
	    showPageList:true,    
	    buttons:[{    
	        iconCls:'icon-add', 
	        text : '添加',
	        handler:function(){    
	        	addDepot();    
	        }    
	    },{    
	        iconCls:'transmit',
	        text :'刷新',
	        handler:function(){    
	        	depotdg.datagrid('reload');  
	        }    
	    }],    
	});    
	
	detaildg=$('#detaildg').datagrid({
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
		        	  width : 50
		          },
		          {
		        	  field : 'binname',
		        	  title : '仓名',
		        	 width : 60
		          },{
		        	 field : 'contract',
		        	 title : '联系人',
		        	 width : 60
		          },
		          {
		        	  field : 'typebin',
		        	  title : '粮仓类型',
		        	 hidden : true,
		        	 width : 60
		          }, {
		        	  field : 'capacity',
		        	  title : '设计容量',
		        	  sortable : true,
		        	  width : 40
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
		        	  field : 'structureofbody',
		        	  title : '仓体结构',
		        	  sortable : true,
		        	  align: 'left',
		        	  width : 90
		          }, {
		        	  field : 'structureofroof',
		        	  title : '顶仓结构',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 90
		          }, {
		        	  field : 'designcapacity',
		        	  title : '设计单仓容量(T)',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 90
		          },{
		        	  field : 'designgrainheapheight',
		        	  title : '设计粮堆高度(m)',
		        	  align: 'center',
		        	  sortable : true,
		        	  width : 90
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
	
	//地区
	areadg=$('#areadg').datagrid({
		//url : 'getArea',
		//pagination : true,
		fitColumns : true,
		fit : true,
		rownumbers : true,// 显示行号
		singleSelect : true,// 只能单选
		border : false,
		striped : true,// 隔行变色
		idField : 'id', // 主键字段
		columns:[[
		          { field : 'id', hidden:true},
		          { field : 'fullname', title:'地区名称'}
		          ]],
		toolbar : '#areatoolbar',
		onClickRow : function(rowIndex, rowData){
			areaClick(rowIndex, rowData);
        },
		onLoadSuccess: function(data){
			if (data.rows.length>0){
				areadg.datagrid('selectRow', 0);
				areaClick(0,data.rows[0]);
			}else{
				depotdg.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
				depotdetail.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
			}
		}
	})
	
	//储粮区 combobox
	$('#graindirect').combobox({    
	    url:'getGraindirect',    
	    valueField:'id',    
	    textField:'fullname',
	    onSelect: function(rec){    
	    	areadg.datagrid({
      		  url : 'getArea',
      		  queryParams:{ graindirectionid : rec.id}
      	  });
	    }
	});  

});

  areaClick = function(rowIndex, rowData){
	  areadg.datagrid('unselectAll');
		areadg.datagrid('selectRow', rowIndex);
		depotdg.datagrid('load',{ areaid : rowData.id});
  }

	function addDepot() {
/* 		window.open("addDepotEntrance", 'addDepot', 
				"height=550,width=500,top=100,left=400,toolbar=no, location=no, directories=no, status=no, menubar=no,copyhistory=no,channelmode=yes");
 */		openBlank('addDepotEntrance',{} );
	}
	
	function editDepot(index,lkbmcode) {
/* 		window.open("", 'editDepot', 
		"height=550,width=500,top=100,left=400,toolbar=no, location=no, directories=no, status=no, menubar=no,copyhistory=no,channelmode=yes");
 */		openBlank('editDepotEntrance',{lkbm:lkbmcode}/* , 'editDepot' */ );
	}
	
	function deleteDepot(id) {
		//console.info(id);
		if (id != undefined) {
			depotdg.datagrid('selectRow', id);
		}
		var rows = depotdg.datagrid('getSelections');
		//console.info(rows);
		if (rows.length>0) {
			parent.$.messager.confirm('询问', '您是否要删除当前粮库吗？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('deleteDepot', {
						lkbm : rows[0].lkbm
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							depotdg.datagrid('reload');
							detaildg.datagrid('reload');
						}else
							parent.$.messager.alert('提示', result.msg, 'error');
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}
	

	
	function addBin() {
		var rows = depotdg.datagrid('getSelections');
		if (rows.length<=0){
			parent.$.messager.alert('提示', '没有选择粮库，不能添加粮仓！', 'info');
			return;
		}
/* 		window.open("addBinEntrance", 'addBin', 
		"height=750,width=1000,top=50,left=400,scrollbars=yes,location=no, directories=no, status=no,copyhistory=no,channelmode=yes"); */
		openBlank('addBinEntrance',{lkbm:rows[0].lkbm, lkmc:rows[0].lkmc}/* , 'addBin' */ );
	}

	function editBin(lcbmcode) {
/* 		window.open("", 'editBin', 
		"height=750,width=1000,top=100,left=400,scrollbars=yes,location=no, directories=no, status=no,copyhistory=no,channelmode=yes"); */
		openBlank('editBinEntrance',{lcbm:lcbmcode}/* , 'editBin'  */);
	}
	
	function deleteBin(id) {
		//console.info(id);
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
	
	// 查询
	function doSearch() {
		depotdg.datagrid('load', {
			// 参数名与后台pojo属性名一致即可自动填充
			'lkbm' : $('#lkbm').val(),
			'lkmc' : $('#lkmc').val(),
			'contact' : $('#contact').val(),
		});
	}
	
	function clearSearch() {
		depotdg.datagrid('load', {});
		$('#lkbm').attr("value", "");
		$('#lkmc').attr("value", "");
		$('#contact').attr("value", "");
	}
	
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',split:true" 
			style="overflow: hidden; ">
		<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',split:true" title="粮库信息" 
			style="overflow: hidden; height: 280px;">
			<div id="toolbar">
				<form><table>
						<tr><td>粮库编码：</td><td><input id="lkbm"  name="lkbm"  type="text" /></td>
						<td>粮库名称：</td><td><input id="lkmc"  name="lkmc"  type="text" /></td>
						<td>联系人：</td><td><input id="contact"  name="contact"  type="text" /></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
									plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
									plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a>
						</td>
						</tr>
				</table></form>
			</div>
			<table id="depotdg"></table>
		</div>
    			
    	<div data-options="region:'center' " title="对应粮仓信息"
			style="overflow: hidden; ">
			<table id="detaildg"  ></table>
		</div>
		<div id="detailtoolbar">  
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:addBin()">添加</a>  
	        <a onclick="detaildg.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
    	</div> 
	  </div>
	</div>
  	<div data-options="region:'east',split:true " title="储粮区域信息"
		style="overflow: hidden;width: 200px;">
		<table id="areadg"  ></table>
  	</div>
  	<div id = "areatoolbar">
  		<form>
  		储粮区：<input id="graindirect" name="graindirect"   >
  		</form>
  	</div>

</body>
</html>