<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
				url : 'editBinAntiphosphine',//$("#inputForm").attr("action"),
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
	
	var $binAntidrugkindsTable = $("#binAntidrugkindsTable");
	var $addAntidrugkinds = $("#addAntidrugkinds");
	var $deleteAntidrugkinds = $("a.deleteAntidrugkinds");
	var indexAntidrugkinds = '${indexAntidrugkinds}';
	// 增加抗性虫种
	$addAntidrugkinds.click(function() {
		var trHtml = 
			'<tr>' +
 				'<td>' + indexAntidrugkinds + '</td><td>' +
					'<input type="text" name="TBinAntidrugkindses[' + indexAntidrugkinds + '].kind" class="binAntidrugkinds">' + '</td>' +  
				'<td >' + '<input type="text" name="TBinAntidrugkindses[' + indexAntidrugkinds + '].densityafter" class="binAntidrugkinds">' + '</td>' +
				'<td >' + '<select name="TBinAntidrugkindses[' + indexAntidrugkinds + '].ifsecond" class="binAntidrugkinds"><option value="">&nbsp;</option><option value="1">有</option><option value="2">无</option></select>' + '</td>' +
				'<td >' + '<input type="text" name="TBinAntidrugkindses[' + indexAntidrugkinds + '].othermeasures" class="binAntidrugkinds">' + '</td>' +
				'<td >' + '<input type="text" name="TBinAntidrugkindses[' + indexAntidrugkinds + '].resistancevalue" class="binAntidrugkinds">' + '</td>' +
				'<td> ' +
					'<a href="javascript:;" class="deleteAntidrugkinds" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$binAntidrugkindsTable.append(trHtml);
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;磷化氢抗性调查分仓汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lcbm" value="${lcbm}"/>
			<input type="hidden" name="id" value="${binAntiphosphine.id }"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="粮仓情况" />
				</li>
				<li>
					<input type="button" value="储粮信息" />
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
			</ul>			
			
			
			<table class="input tabContent">
				<tr><th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td></tr>
				<tr><th> 粮库编号：</th> <td>${lkbm} </tr>
				<tr><th> 年份：</th> <td>${binAntiphosphine.annual} </tr>
				<tr><th> 熏蒸规模（吨/年）：</th><td><input type="text" name="cascale" class="text" value="${binAntiphosphine.cascale}"/></td>
					<th> 熏蒸粮食比例（%）：</th><td><input type="text" name="proportion"  class="text" value="${binAntiphosphine.proportion}"/></td></tr>
				<tr><th> 熏蒸设施：</th> <td colspan="3"><input type="text" name="device" style="width:90%;" value="${binAntiphosphine.device}"/></td></tr>
				<tr><th> 开始日期：</th><td><input type="text" name="startdate" class="easyui-datebox" value="${binAntiphosphine.startdate}"/></td><th> 结束日期：</th><td><input type="text" name="enddate" class="easyui-datebox" value="${binAntiphosphine.enddate}"/></td></tr>
				<tr><th> 填报人：</th><td><input type="text" value="${binAntiphosphine.reporter}" class="text" name="reporter"/></td>
					<th> 填表日期：</th><td><input type="text" name="reportdate" class="easyui-datebox" value="${binAntiphosphine.reportdate}"/></td></tr>
				<tr><th> 录入人：</th><td>${binAntiphosphine.modifier}</td>
					<th> 录入时间：</th><td>${binAntiphosphine.modifytime}</td></tr>
			</table>
			
			<!-- 粮仓情况 -->
			<table class="input tabContent">
				<tr><th> 仓型：</th><td>${grainbin.typebin}</td><th> 仓号：</th><td>${lcbm}</td></tr>
				<tr><th> 建设规模(吨)：</th><td>${grainbin.designcapacity}</td><th> 储粮规模(吨)：</th><td>${grainbin.capacity}</td></tr>
				<tr><th> 仓长(米)：</th><td>${grainbin.longth}</td><th> 仓宽(米)</th><td>${grainbin.width}</td></tr>
				<tr><th> 设计粮堆高度(米)：</th><td>${grainbin.height}</td><th> 仓体结构：</th><td>${grainbin.structureofbody}</td></tr>
				<tr><th> 环流装置：</th><td>${grainbin.circulatedevice}</td></tr>
				<tr><th> 环流风机：</th><td>${grainbin.circulatefan}</td></tr>
				<tr><th> 仓房风道：</th><td>${grainbin.fanway}</td></tr>
				<tr><th> 通过改善仓储条件进行害虫的预防：</th><td>${grainbin.circulatedevice}</td></tr>
				<tr><th> 其它设施：</th><td>${grainbin.elsedevice}</td></tr>				
			</table>
			
			<!-- 储粮信息 -->
			<table class="input tabContent">
				<tr><th> 粮种名称：</th><td>${grain.grainname}</td><th> 装粮形式：</th> <td>${grain.clxs}</td></tr>
				<tr><th> 收获日期：</th><td>${grain.harvestdate}</td><th> 入储日期：</th> <td>${grain.indate}</td></tr>
				<tr><th> 水分：</th><td>${grain.water}</td><th> 杂质：</th> <td>${grain.impurity}</td></tr>
				<tr><th> 干燥方式：</th><td>${grain.dryingmethod}</td><th> 存储年限（年）：</th> <td>${grain.reserveperiod}</td></tr>
				<tr><th> 入储数量（吨）：</th><td>${grain.innum}</td><th> 装具：</th> <td>${grain.container}</td></tr>
				<tr><th> 空仓500pa（秒）：</th><td>${grain.empty_bin500pa}</td><th> 空仓半衰500pa（秒）：</th> <td>${grain.halfemptybin500pa}</td></tr>
				<tr><th> 满仓300pa（秒）：</th><td>${grain.fullbin300pa}</td><th> 满仓半衰300pa（秒）：</th> <td>${grain.halffullbin}</td></tr>
				<tr><th> 储藏技术：</th><td>${grain.storetechnology}</td><th> 储藏方式：</th> <td>${grain.storemethod}</td></tr>
				<tr><th> 控温措施：</th><td>${grain.controltemperaturemeasures}</td><th> 控湿措施：</th> <td>${grain.controlhumiditymeasures}</td></tr>
				<tr><th> 来源：</th><td>${grain.source}</td><th> 实际粮堆高度（米）：</th> <td>${grain.grainheight}</td></tr>
			</table>
			
			<table class="input tabContent">
				<tr><th> 累计熏蒸时间（天）：</th><td><input type="text" name="totaldays" class="text" value="${binAntiphosphine.totaldays}"/></td>
					<th> 环流方式：</th><td><input type="text" name="circulationway"  class="text" value="${binAntiphosphine.circulationway}"/></td></tr>
				<tr><th> 平均最高浓度(ppm)：</th><td><input type="text" name="highestppm" class="text" value="${binAntiphosphine.highestppm}"/></td>
					<th> 目标熏蒸浓度维持时间：</th><td><input type="text" name="targetdays"  class="text" value="${binAntiphosphine.targetdays}"/></td></tr>
				<tr><th> 熏蒸时最低粮温(℃)：</th> <td><input type="text" name="lowesttemperature" class="text" value="${binAntiphosphine.lowesttemperature}"/></td>
					<th> 熏蒸时最高粮温(℃)：</th> <td><input type="text" name="highesttemperature" class="text" value="${binAntiphosphine.highesttemperature}"/></td></tr>
				<tr><th> 熏蒸时平均粮温(℃)：</th> <td><input type="text" name="avgtemperature" class="text" value="${binAntiphosphine.avgtemperature}"/></td></tr>
			</table>
			
			<table class="input tabContent">
				<tr><th> 熏蒸前虫种：</th><td><input type="text" name="kindbefca" class="text" value="${binAntiphosphine.kindbefca}"/></td>
					<th> 熏蒸前虫口密度：</th><td><input type="text" name="densitybefca"  class="text" value="${binAntiphosphine.densitybefca}"/></td></tr>
				<tr><th> 熏蒸后虫种：</th><td><input type="text" name="kindafterca" class="text" value="${binAntiphosphine.kindafterca}"/></td>
					<th> 熏蒸后虫口密度：</th><td><input type="text" name="densityafterca"  class="text" value="${binAntiphosphine.densityafterca}"/></td></tr>
				<tr><th> 熏蒸平均浓度范围：</th> <td><input type="text" name="varconcentration" class="text" value="${binAntiphosphine.varconcentration}"/></td></tr>
				<tr><th> 无虫期间隔（天）：</th><td><input type="text" name="noninsects" class="text" value="${binAntiphosphine.noninsects}"/></td></tr>
				<tr><th> 是否放置虫笼（虫源）：</th>
					<td>
						<select name="ifcage">
						<option value="">&nbsp;</option>
						<option value="1" <c:if test="${binAntiphosphine.ifcage+0 == 49}">selected</c:if>>是</option>
						<option value="2" <c:if test="${binAntiphosphine.ifcage+0 == 50}">selected</c:if>>否</option></select>
					</td>
					<th> 虫笼虫种：</th><td><input type="text" name="cagekind"  class="text" value="${binAntiphosphine.cagekind}"/></td></tr>
				<tr><th> 虫笼中虫口数量（熏蒸前）：</th><td><input type="text" name="cagenumbef" class="text" value="${binAntiphosphine.cagenumbef}"/></td>
					<th> 虫笼中有无活虫（熏蒸后）：</th>
					<td>
						<select name="hasliveinsectsafter">
						<option value="">&nbsp;</option>
						<option value="1" <c:if test="${binAntiphosphine.hasliveinsectsafter+0 == 49}">selected</c:if>>有</option>
						<option value="2" <c:if test="${binAntiphosphine.hasliveinsectsafter+0 == 50}">selected</c:if>>无</option></select>
					</td></tr>
			</table>
			
			<table id="binAntidrugkindsTable" class="input tabContent">
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
				<c:forEach var="binAntidrugkinds" items="${binAntiphosphine.TBinAntidrugkindses}" varStatus="status">
					<tr><td>${status.index}<input type="hidden" name="TBinAntidrugkindses[${status.index}].id" value="${binAntidrugkinds.id}" /></td>
						<td><input type="text" name="TBinAntidrugkindses[${status.index}].kind" value="${binAntidrugkinds.kind}" class="binAntidrugkinds"/></td>
						<td><input type="text" name="TBinAntidrugkindses[${status.index}].densityafter" value="${binAntidrugkinds.densityafter}" class="binAntidrugkinds"/></td>
						<td>
							<select name="TBinAntidrugkindses[${status.index}].ifsecond" class="binAntidrugkinds">
								<c:set var="ifsecond" value="${binAntidrugkinds.ifsecond}"/>
								<option value="">&nbsp;</option>
								<option value="1" <c:if test="${ifsecond+0 == 49}">selected</c:if>>是</option>
								<option value="2" <c:if test="${ifsecond+0 == 50}">selected</c:if>>否</option>
							</select></td>
						<td><input type="text" name="TBinAntidrugkindses[${status.index}].othermeasures" value="${binAntidrugkinds.othermeasures}" class="binAntidrugkinds"/></td>
						<td><input type="text" name="TBinAntidrugkindses[${status.index}].resistancevalue" value="${binAntidrugkinds.resistancevalue}" class="binAntidrugkinds"/></td>
						<td>
							<a href="javascript:;" class="deleteAntidrugkinds">[ 删除 ]</a>
						</td>
					</tr>					
				</c:forEach>
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