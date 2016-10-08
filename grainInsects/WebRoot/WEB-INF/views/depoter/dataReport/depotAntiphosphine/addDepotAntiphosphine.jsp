<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<style>
	.antidrugkinds {
		width: 80px;
		height: 24px;
		padding-left: 5px;
	}
</style>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {
	var $inputForm = $("#inputForm");
	// 表单验证
	$inputForm.validate({
		rules: {
/* 			pass: {
				pattern: /^[^\s&\"<>]+$/,
				minlength: 4,
				maxlength: 20
			},
			rePass: {
				equalTo: "#pass"
			},
			hasaudit:{required:true},
			manager:{required:true},
			graindepotid:{required:true}, */
		},
 		submitHandler: function() {
 			var formData = new FormData($( "#inputForm" )[0]); 
 			$("table input[type=checkbox]").each(function(){
 				if ($(this).attr("checked"))
 					$(this).val(1);
 				else
 					$(this).val(0);
 			});
 			var data=$("#inputForm").serialize();
 			data = data.replace(/\+/g," ");   // g表示对整个字符串中符合条件的都进行替换
			$.ajax({
				url : 'addDepotAntiphosphine',//$("#inputForm").attr("action"),
				data : data, //$("#inputForm").serialize(),
				dataType : 'json',
/*  				contentType: false,  
		        processData: false,   */
				success : function(r) {
					if (r && r.success) {
						parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
						goback();
					} else {
						parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
					}
				}
			});
		} 
	});
	
	var $depotAntidrugkindsTable = $("#depotAntidrugkindsTable");
	var $addAntidrugkinds = $("#addAntidrugkinds");
	var $deleteAntidrugkinds = $("a.deleteAntidrugkinds");
	var indexAntidrugkinds = 0;
	// 增加抗性虫种
	$addAntidrugkinds.click(function() {
		var trHtml = 
			'<tr>' +
 				'<td>' + indexAntidrugkinds + '</td><td>' +
					'<input type="text" name="depotAntidrugkindses[' + indexAntidrugkinds + '].kind" class="antidrugkinds">' + '</td>' +  
				'<td >' + '<input type="text" name="depotAntidrugkindses[' + indexAntidrugkinds + '].densityafter" class="antidrugkinds">' + '</td>' +
				'<td >' + '<select name="depotAntidrugkindses[' + indexAntidrugkinds + '].ifsecond" class="antidrugkinds"><option value="">&nbsp;</option><option value="1">有</option><option value="2">无</option></select>' + '</td>' +
				'<td >' + '<input type="text" name="depotAntidrugkindses[' + indexAntidrugkinds + '].othermeasures" class="antidrugkinds">' + '</td>' +
				'<td >' + '<input type="text" name="depotAntidrugkindses[' + indexAntidrugkinds + '].resistancevalue" class="antidrugkinds">' + '</td>' +
				'<td> ' +
					'<a href="javascript:;" class="deleteAntidrugkinds" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$depotAntidrugkindsTable.append(trHtml);
		indexAntidrugkinds ++;
	});
	// 删除抗性虫种
	$deleteAntidrugkinds.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该抗性虫种记录吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
 	
});
	//submit the form
 	doAdd = function(){
		$("#inputForm").submit();
	} 
	
	goback = function(){
		window.history.back();
	}

</script>	
</head>
<body >
	<div class="container" >
		<br>&nbsp;&nbsp;&nbsp;&raquo;磷化氢抗性调查汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm }"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="熏蒸杀虫" />
				</li> 
				<li>
					<input type="button" value="防治效果" />
				</li> 
				<li>
					<input type="button" value="抗性虫种" />
				</li> 
				<li>
					<input type="button" value="意见与建议" />
				</li> 
			</ul>			
			<table class="input tabContent">
				<tr><th> 粮库名称：</th> <td> ${lkmc}</td><th> 粮库编号：</th> <td>${lkbm}</tr>
				<tr><th><span class="requiredField">*</span> 年度：</th><td><input type="text" name="annual" ></td><th> 联系电话：</th><td><input type="text" name="phone" class="text"/></td></tr>
				<tr><th> 熏蒸规模（吨/年）：</th><td><input type="text" name="cascale" class="text" /></td>
					<th> 熏蒸粮食比例（%）：</th><td><input type="text" name="proportion"  class="text" /></td></tr>
				<tr><th> 熏蒸设施：</th> <td colspan="3"><input type="text" name="device" style="width:85%;" /></td></tr>
				<tr><th> 填报人：</th><td><input type="text" name="reporter" class="text"/></td><th> 填报日期：</th><td><input type="text" name="reportdate" class="easyui-datebox"/></td></tr>
			</table>
			
			<table class="input tabContent">
				<tr><th> 累计熏蒸时间（天）：</th><td><input type="text" name="totaldays" class="text" /></td>
					<th> 环流方式：</th><td><input type="text" name="circulationway"  class="text" /></td></tr>
				<tr><th> 平均最高浓度(ppm)：</th><td><input type="text" name="highestppm" class="text" /></td>
					<th> 目标熏蒸浓度维持时间：</th><td><input type="text" name="targetdays"  class="text" /></td></tr>
				<tr><th> 熏蒸时最低粮温(℃)：</th> <td><input type="text" name="lowesttemperature" class="text" /></td>
					<th> 熏蒸时最高粮温(℃)：</th> <td><input type="text" name="highesttemperature" class="text" /></td></tr>
				<tr><th> 熏蒸时平均粮温(℃)：</th> <td><input type="text" name="avgtemperature" class="text" /></td></tr>
			</table>
			
			<table class="input tabContent">
				<tr><th> 熏蒸前虫种：</th><td><input type="text" name="kindbefca" class="text" /></td>
					<th> 熏蒸前虫口密度：</th><td><input type="text" name="densitybefca"  class="text" /></td></tr>
				<tr><th> 熏蒸后虫种：</th><td><input type="text" name="kindafterca" class="text" /></td>
					<th> 熏蒸后虫口密度：</th><td><input type="text" name="densityafterca"  class="text" /></td></tr>
				<tr><th> 熏蒸平均浓度范围：</th> <td><input type="text" name="varconcentration" class="text" /></td></tr>
				<tr><th> 无虫期间隔（天）：</th><td><input type="text" name="noninsects" class="text" /></td></tr>
				<tr><th> 是否放置虫笼（虫源）：</th><td><select name="ifcage"><option value="">&nbsp;</option><option value="1">是</option><option value="2">否</option></select></td>
					<th> 虫笼虫种：</th><td><input type="text" name="cagekind"  class="text" /></td></tr>
				<tr><th> 虫笼中虫口数量（熏蒸前）：</th><td><input type="text" name="cagenumbef" class="text" /></td>
					<th> 虫笼中有无活虫（熏蒸后）：</th><td><select name="hasliveinsectsafter"><option value="">&nbsp;</option><option value="1">有</option><option value="2">无</option></select></td></tr>
			</table>
			
			<table id="depotAntidrugkindsTable" class="input tabContent">
				<tr>
					<td colspan="10">
						<a href="javascript:;" id="addAntidrugkinds" class="button">增加抗性虫种</a>
					</td>
				</tr>
				<tr class="title">
					<td>序号</td>
					<td>虫种名称</td>
					<td>熏蒸后虫口密度</td>
					<td>是否二次熏蒸</td>
					<td>其他措施</td>
					<td>抗性初判（1-无抗性 2-略有抗性 3-有抗性 4-抗性较高 5-抗性很高）</td>
				</tr>
			</table> 
			
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="editor" name="suggestion" class="editor" style="width: 98%;"></textarea>
					</td>
				</tr>
			</table>
			
			<table class="input">
				<tr>
					<th>&nbsp;</th>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							plain="false" onclick="doAdd()" iconCls="icon-save">保存</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							plain="false" onclick="goback()" iconCls="icon-back">返回</a>
					</td>
				</tr>	
			</table>							
		</form>
	</div>
</body>
</html>