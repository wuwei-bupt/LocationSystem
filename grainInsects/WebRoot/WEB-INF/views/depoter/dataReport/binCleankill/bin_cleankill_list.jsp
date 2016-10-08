<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>空仓杀虫储粮害虫防治调查明细表</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">

	var dataGrid;
	$(document).ready(function() {
		getYear();
		getGrainBin();
		
		$("#year").change(getDataGrid);
		$("#grain-bin").change(getDataGrid);
	});
    
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : 'getBinCleankillList',
			pagination: true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'id', // 主键字段
			columns : [ [ {
				field : 'id',
				title : 'ID',
				width : 40
			},
			 {
				field : 'annual',
				title : '年度',
				width : 50,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (row!=null) return row.annual;}
			},{
				field : 'lcbm',
				title : '粮仓编码',
				width : 40,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (row!=null && row.tgrainbin!=null) {return row.tgrainbin.lcbm;}}
			},{
				field : 'drug',
				title : '药剂名称',
				width : 40,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (row!=null) return row.drug;}
			}, {
				field : 'startdate',
				title : '开始日期',
				width : 40,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (row!=null) { return row.startdate;}}
			},{
				field : 'enddate',
				title : '结束日期',
				width : 40,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (row!=null) return row.enddate;}
			},{
				field : 'reporter',
				title : '填表人',
				width : 40,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (row!=null) return row.reporter;}
			},{
				field : 'reportdate',
				title : '填表日期',
				width : 40,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (row!=null) return row.reportdate;}
			},{
				field : 'actor',
				title : '操作',
				width : 40,
				formatter : function(value, row, index) {
					var str = '';
				    str += $.formatString('<img onclick="editFun(\'{0}\',\'{1}\',\'{2}\');" src="{3}" title="修改"/> ',row.id,$("#grain-bin").val(),row.tgrainbin.lcbm, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
					str += '&nbsp;';
				    str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/> ',row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
		});		
	});

    function getDataGrid() {
		
		var year = $("#year");
		var bin = $("#grain-bin");

		if (year.val() != '0' && bin.val() != '0') {
			getDataFun(year.val(),bin.val());
		}
	}
    function getDataFun(year,bin) {
		dataGrid.datagrid({
			queryParams:{
				'Annual' : year,
				'lcbm' : bin
			}
		});
	}
    /*
	function getDataFun(year,bin) {
		parent.$.messager.progress({
			title : '提示',
			text : '数据处理中，请稍后....'
		});
		$.post('getBinCleankillList', {
			'Annual' : year,
			'lcbm' : bin
		}, function(result) {
			dataGrid.datagrid('loadData',result);
			parent.$.messager.progress('close');
		}, 'JSON');
	}
    */
	function deleteFun(id) {
		if (id!=null){
			parent.$.messager.confirm('询问', '您是否要删除当前上报记录?', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('deleteBinCleankillReportRec', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}else
							parent.$.messager.alert('提示', result.msg, 'error');
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}

    function getYear() {
    	$("#year").html("");
		var y = new Date().getFullYear();
		for (var i = 2000; i <= y; i++) {
			var x = "<option value='"+i+"'"+(i != y ? '' : 'selected=\'selected\'')+">"+i+"年"+"</option>";
			$("#year").append(x);
		}
	}
	
	function getGrainBin() {
		$.ajax({
			url:'grainBins',
			method:'get',
			success:function(data) {
				var json = eval("("+data+")");
				$("#grain-bin").html("");
				$("#grain-bin").append("<option selected='selected' value='0'>请选择粮仓...</option>");
				for (var c in json) {
					var x = "<option value='"+json[c].lcbm+"'>"+json[c].lcbm+"号粮仓"+"</option>";
					$("#grain-bin").append(x);
				}
			}
		});
	}
	function editFun(index,bin_number,table_bin_number) {
        if(bin_number!=0)
		  openBlank('editBinCleankillEntrance',{id:index,lcbm:bin_number});
        else
          openBlank('editBinCleankillEntrance',{id:index,lcbm:table_bin_number});
	}

	function addFun() {
		if($("#grain-bin").val() == "0") {
			parent.$.messager.alert('提示', '请选择粮仓', 'info');	
			return;
		}
		 openBlank('addBinCleankillEntrance',{lcbm:$("#grain-bin").val(),annual:$("#year").val()});
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="数据上报  > 空仓杀虫分仓表" style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
		<div id="toolbar" style="display: none;">
		<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		<span>空仓杀虫储粮害虫防治调查明细表</span>
        <select id="year" style="margin-left:30px;">
			<option selected="selected" value='0'>请选择年份...</option>
			<option value='1'>...</option>
		</select>
		
		<select id="grain-bin">
			<option selected="selected" value='0'>请选择粮库...</option>
			<option value='1'>...</option>
		</select>
	</div>
</body>
</html>