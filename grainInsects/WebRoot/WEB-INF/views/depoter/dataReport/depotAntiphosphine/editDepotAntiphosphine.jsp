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
				url : 'editDepotAntiphosphine',//$("#inputForm").attr("action"),
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
	var indexAntidrugkinds = '${indexAntidrugkinds}';
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
			<input type="hidden" name="id" value="${depotAntiphosphine.id }"/>
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
				<tr><th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td></tr>
				<tr><th> 粮库编号：</th> <td>${lkbm} </tr>
				<tr><th><span class="requiredField">*</span> 年度：</th><td colspan="3"><input type="text" name="annual" value="${depotAntiphosphine.annual}" /></td></tr>
				<tr><th> 熏蒸规模（吨/年）：</th><td><input type="text" name="cascale" class="text" value="${depotAntiphosphine.cascale}"/></td>
					<th> 熏蒸粮食比例（%）：</th><td><input type="text" name="proportion"  class="text" value="${depotAntiphosphine.proportion}"/></td></tr>
				<tr><th> 熏蒸设施：</th> <td colspan="3"><input type="text" name="device" style="width:85%;" value="${depotAntiphosphine.device}"/></td></tr>
				<tr><th> 填报人：</th><td><input type="text" class="text" name="reporter" value="${depotAntiphosphine.reporter}"/></td>
					<th> 填表日期：</th><td><input type="text" name="reportdate" class="easyui-datebox" value="${depotAntiphosphine.reportdate}"/></td></tr>
				<tr><th> 录入人：</th><td>${depotAntiphosphine.modifier}</td>
					<th> 录入时间：</th><td>${depotAntiphosphine.modifytime}</td></tr>
			</table>
			
			<table class="input tabContent">
				<tr><th> 累计熏蒸时间（天）：</th><td><input type="text" name="totaldays" class="text" value="${depotAntiphosphine.totaldays}"/></td>
					<th> 环流方式：</th><td><input type="text" name="circulationway"  class="text" value="${depotAntiphosphine.circulationway}"/></td></tr>
				<tr><th> 平均最高浓度(ppm)：</th><td><input type="text" name="highestppm" class="text" value="${depotAntiphosphine.highestppm}"/></td>
					<th> 目标熏蒸浓度维持时间：</th><td><input type="text" name="targetdays"  class="text" value="${depotAntiphosphine.targetdays}"/></td></tr>
				<tr><th> 熏蒸时最低粮温(℃)：</th> <td><input type="text" name="lowesttemperature" class="text" value="${depotAntiphosphine.lowesttemperature}"/></td>
					<th> 熏蒸时最高粮温(℃)：</th> <td><input type="text" name="highesttemperature" class="text" value="${depotAntiphosphine.highesttemperature}"/></td></tr>
				<tr><th> 熏蒸时平均粮温(℃)：</th> <td><input type="text" name="avgtemperature" class="text" value="${depotAntiphosphine.avgtemperature}"/></td></tr>
			</table>
			
			<table class="input tabContent">
				<tr><th> 熏蒸前虫种：</th><td><input type="text" name="kindbefca" class="text" value="${depotAntiphosphine.kindbefca}"/></td>
					<th> 熏蒸前虫口密度：</th><td><input type="text" name="densitybefca"  class="text" value="${depotAntiphosphine.densitybefca}"/></td></tr>
				<tr><th> 熏蒸后虫种：</th><td><input type="text" name="kindafterca" class="text" value="${depotAntiphosphine.kindafterca}"/></td>
					<th> 熏蒸后虫口密度：</th><td><input type="text" name="densityafterca"  class="text" value="${depotAntiphosphine.densityafterca}"/></td></tr>
				<tr><th> 熏蒸平均浓度范围：</th> <td><input type="text" name="varconcentration" class="text" value="${depotAntiphosphine.varconcentration}"/></td></tr>
				<tr><th> 无虫期间隔（天）：</th><td><input type="text" name="noninsects" class="text" value="${depotAntiphosphine.noninsects}"/></td></tr>
				<tr><th> 是否放置虫笼（虫源）：</th>
					<td>
						<select name="ifcage">
						<option value="">&nbsp;</option>
						<option value="1" <c:if test="${depotAntiphosphine.ifcage+0 == 49}">selected</c:if>>是</option>
						<option value="2" <c:if test="${depotAntiphosphine.ifcage+0 == 50}">selected</c:if>>否</option></select>
					</td>
					<th> 虫笼虫种：</th><td><input type="text" name="cagekind"  class="text" value="${depotAntiphosphine.cagekind}"/></td></tr>
				<tr><th> 虫笼中虫口数量（熏蒸前）：</th><td><input type="text" name="cagenumbef" class="text" value="${depotAntiphosphine.cagenumbef}"/></td>
					<th> 虫笼中有无活虫（熏蒸后）：</th>
					<td>
						<select name="hasliveinsectsafter">
						<option value="">&nbsp;</option>
						<option value="1" <c:if test="${depotAntiphosphine.hasliveinsectsafter+0 == 49}">selected</c:if>>有</option>
						<option value="2" <c:if test="${depotAntiphosphine.hasliveinsectsafter+0 == 50}">selected</c:if>>无</option></select>
					</td></tr>
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
				<c:forEach var="antidrugkinds" items="${depotAntiphosphine.depotAntidrugkindses}" varStatus="status">
					<tr><td>${status.index}<input type="hidden" name="depotAntidrugkindses[${status.index}].id" value="${antidrugkinds.id}" /></td>
						<td><input type="text" name="depotAntidrugkindses[${status.index}].kind" value="${antidrugkinds.kind}" class="antidrugkinds"/></td>
						<td><input type="text" name="depotAntidrugkindses[${status.index}].densityafter" value="${antidrugkinds.densityafter}" class="antidrugkinds"/></td>
						<td>
							<select name="depotAntidrugkindses[${status.index}].ifsecond" class="antidrugkinds">
								<c:set var="ifsecond" value="${antidrugkinds.ifsecond}"/>
								<option value="">&nbsp;</option>
								<option value="1" <c:if test="${ifsecond+0 == 49}">selected</c:if>>是</option>
								<option value="2" <c:if test="${ifsecond+0 == 50}">selected</c:if>>否</option>
							</select></td>
						<td><input type="text" name="depotAntidrugkindses[${status.index}].othermeasures" value="${antidrugkinds.othermeasures}" class="antidrugkinds"/></td>
						<td><input type="text" name="depotAntidrugkindses[${status.index}].resistancevalue" value="${antidrugkinds.resistancevalue}" class="antidrugkinds"/></td>
						<td>
							<a href="javascript:;" class="deleteAntidrugkinds">[ 删除 ]</a>
						</td>
					</tr>					
				</c:forEach>
			</table> 
					
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="editor" name="suggestion"  style="width: 98%; "> ${depotAntiphosphine.suggestion}</textarea>
					</td>
				</tr>
			</table>	
					
			<table class="input">
				<tr><th>&nbsp;</th>
				<td >
				<!--  <input type="submit" class="button" value="save" /> -->
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