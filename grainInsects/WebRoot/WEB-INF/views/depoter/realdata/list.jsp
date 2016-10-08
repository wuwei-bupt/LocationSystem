<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html>
<head>
<title>数据列表</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		getGrainBin();
		$("#grain-bin").change(doSearch);
	});
	var contextPath = "<%= request.getContextPath() %>"+"/admin/depot/user";
	// 查询
	function doSearch() {
		// 取得查询条件，发送给后台
/* 		if($("#grain-bin").val() == "0") {
			parent.$.messager.alert('提示', '请选择粮仓', 'info');	
			return;
		} */
		$('#dataGrid').datagrid('load', {
			'lcbm'            : $("#grain-bin").val(),
			'collectStart'    : $("[name='collectStart']").val().replace(/-/g, ''),
			'collectEnd'      : $("[name='collectEnd']").val().replace(/-/g, ''),
			'kind'	          : $('#kind').val(),
			'source'          : $('#source').val(),
			'numStart'        : $('#numStart').val(),
			'numEnd'          : $('#numEnd').val(),
			'temperatureStart': $('#temperatureStart').val(),
			'temperatureEnd'  : $('#temperatureEnd').val(),
			'humidityStart'   : $('#humidityStart').val(),
			'humidityEnd'     : $('#humidityEnd').val()
		});
	}
	// 清查询条件
	function clearSearch() {
		$('#dataGrid').datagrid('load', {});
		$('#collectStart').attr("value", "");
		$('#collectEnd').attr("value", "");
		$('#kind').attr("value", "");
		$('#source').attr("value", "");
		$('#numStart').attr("value", "");
		$('#numEnd').attr("value", "");
		$('#temperatureStart').attr("value", "");
		$('#temperatureEnd').attr("value", "");
		$('#humidityStart').attr("value", "");
		$('#humidityEnd').attr("value", "");
	}

	var dataGrid;
	$(function() {
		//showFlash("${FlashMessage}");
		
		editrow='undefined';			//行编辑开关
		dataGrid = $('#dataGrid').datagrid({
			url : 'dataGrid',
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
				hidden: 'true',
				width : 40
			},{
				field : 'tgrainbin',
				title : '粮仓编码',
				width : 50,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (value!=null) return value.lcbm;	},
			},{
				field : 'temperature',
				title : '温度（℃）',
				width : 30,
				sortable : true,
				align : "center",
			},{
				field : 'humidity',
				title : '湿度',
				width : 30,
				sortable : true,
				align : "center",
			},{
				field : 'kind',
				title : '虫种',
				width : 50,
				sortable : true,
				align : "center",
			},{
				field : 'deviceno',
				title : '设备号',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'x',
				title : 'X',
				width : 20,
				sortable : true,
				align : "center",
			},
			{
				field : 'y',
				title : 'Y',
				width : 20,
				sortable : true,
				align : "center",
			},
			{
				field : 'z',
				title : 'Z',
				width : 20,
				sortable : true,
				align : "center",
			},{
				field : 'num',
				title : '害虫数量',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'collecttime',
				title : '采集时刻',
				width : 60,
				sortable : true,
				align : "center",
			}, {
				field : 'source',
				title : '信息来源',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'actor',
				title : '操作',
				width : 40,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('<a onclick="detailFunc(\'{0}\')">查看详情</a>',row.id);
					return str;
				}
			} ] ],
			toolbar : '#toolbar',

			onLoadSuccess : function() {
				parent.$.messager.progress('close');
				$(this).datagrid('tooltip');
			},
		});
	});

	function getGrainBin() {
		$.ajax({
			url:'grainBins',
			method:'get',
			success:function(data) {
				var json = eval("("+data+")");
				$("#grain-bin").html("");
				$("#grain-bin").append("<option selected='selected' value='-1'>请选择粮仓...</option>");
				for (var c in json) {
					var x = "<option value='"+json[c].lcbm+"'>"+json[c].lcbm+"号粮仓"+"</option>";
					$("#grain-bin").append(x);
				}
			}
		});
	}

	function detailFunc(index) {
		openBlank('detail',{id:index});
	}
</script>
<style>

.input-group {
	padding:5px 10px 0px 10px;
	display: inline-block;
}
</style>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div region="north" title="监控预报 > 数据列表 > 过滤条件" style="height:100px ;overflow:hidden;">
		<div>
			<div class="input-group">
				<span>信息采集时刻:</span>
				<input name="collectStart" class="easyui-datebox"/>到
				<input name="collectEnd" class="easyui-datebox"/>
			</div>	
			<div class="input-group">
				<span>虫种:</span>
				<input id="kind" class="text"/>
			</div>
			<div class="input-group">
				<span>信息来源:</span>
				<input id="source" class="text"/>
			</div>
		</div>
		<div>
			<div class="input-group">
				<span>害虫数量:</span>
				<input id="numStart" style="max-width:50px;" class="text"/>到
				<input id="numEnd" style="max-width:50px;" class="text"/>
			</div>
			<div class="input-group">
				<span>温度:</span>
				<input id="temperatureStart" style="max-width:50px;" class="text"/>到
				<input id="temperatureEnd" style="max-width:50px;" class="text"/>
			</div>
			<div class="input-group">
				<span>湿度:</span>
				<input id="humidityStart" style="max-width:50px;" class="text"/>到
				<input id="humidityEnd" style="max-width:50px;" class="text"/>
			</div>
			<div class="input-group">
				<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a>
			</div>
		</div>
    </div>
	<div data-options="region:'center',border:false" title="监控预报 > 数据列表" style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
	<div id="toolbar" style="display: none;">
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		<select id="grain-bin">
			<option selected="selected" value='-1'>请选择粮库...</option>
			<option value='1'>...</option>
		</select>
	</div>

</body>
</html>