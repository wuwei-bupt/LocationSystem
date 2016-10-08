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
				url : 'editBinFlyline',//$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;防虫线防治效果调查明细表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lcbm" value="${lcbm }"/> 
			<input type="hidden" name="id" value="${binFlyline.id }"/> 
			<ul id="tab" class="tab">
				<li><input type="button" value="基本情况" /></li>
				<li><input type="button" value="粮仓情况" /></li>
				<li><input type="button" value="储粮情况" /></li>
				<li><input type="button" value="成本核算" /></li>
				<li><input type="button" value="空仓杀虫" /></li>
				<li><input type="button" value="防治效果" /></li>
			</ul>
			<table class="input tabContent">
				<!-- 基本情况 -->
				<tr>
					<th>粮库名称：</th>
					<td colspan="3">${lkmc}</td>
				</tr>
				<tr>
					<th>粮库编号：</th>
					<td>${lkbm}
					<th><span class="requiredField">*</span> 年 度</th>
					<td>${binFlyline.annual}</td>
				</tr>
				<tr><th> 开始日期：</th><td><input type="text" name="startdate" class="easyui-datebox" value="${binFlyline.startdate}"/></td><th> 结束日期：</th><td><input type="text" name="enddate" class="easyui-datebox" value="${binFlyline.enddate}"/></td></tr>
				<tr><th> 填报人：</th><td><input type="text" class="text" name="reporter" value="${binFlyline.reporter}"/></td><th>填报日期:</th><td><input type="text" class="easyui-datebox" name="reportdate" value="${binFlyline.reportdate}"/></td></tr>
				<tr><th> 录入人：</th><td>${binFlyline.modifier}</td>
					<th> 录入时间：</th><td>${binFlyline.modifydate}</td></tr>
<!-- 				<tr> -->
<!-- 					<th>药剂名称：</th> -->
<%-- 					<td><input type="text" name="brand" class="text" value="${binFlyline.totaluse}"/></td> --%>
<!-- 					<th>药剂厂家：</th> -->
<%-- 					<td><input type="text" name="brand" class="text" value="${binFlyline.proportion}"/></td> --%>
<!-- 				</tr> -->
				<tr>
					<th>施药设施及方法：</th>
					<td colspan="3"><input type="text" name="deviceandway"
						class="text" style="width: 80%;" value="${binFlyline.deviceandway}"/></td>
				</tr>
			</table>

			<!-- 粮仓情况 -->
			<table class="input tabContent">
				<tr><th> 仓型：</th><td>${grainbin.typebin}</td><th> 仓号：</th><td>${lcbm}</td></tr>
				<tr><th> 建设规模(吨)：</th><td>${grainbin.designcapacity}</td><th> 储粮规模(吨)：</th><td>${grainbin.capacity}</td></tr>
				<tr><th> 仓长(米)：</th><td>${grainbin.longth}</td><th> 仓宽(米)</th><td>${grainbin.width}</td></tr>
				<tr><th> 设计粮堆高度(米)：</th><td>${grainbin.height}</td><th> 仓体结构：</th><td>${grainbin.structureofbody}</td></tr>
				<tr><th> 环流装置：</th><td colspan="3">${grainbin.circulatedevice}</td></tr>
				<tr><th> 环流风机：</th><td colspan="3">${grainbin.circulatefan}</td></tr>
				<tr><th> 仓房风道：</th><td colspan="3">${grainbin.fanway}</td></tr>
				<tr><th> 通过改善仓储条件进行害虫的预防：</th><td colspan="3">${grainbin.circulatedevice}</td></tr>
				<tr><th> 其它设施：</th><td colspan="3">${grainbin.elsedevice}</td></tr>				
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
				<!-- 成本核算 -->
				<tr>
					<th>施药器械（元）：</th>
					<td><input type="text" name="device" class="text" value="${binFlyline.device}" /></td>
					<th>防虫线杀虫剂药剂（品牌）：</th>
					<td><input type="text" name="brand" class="text" value="${binFlyline.brand}"/></td>
				</tr>
				<tr>
					<th>空仓杀虫剂用量（kg）：</th>
					<td><input type="text" name="dosage" class="text" value="${binFlyline.dosage}"/></td>
					<th>防虫线杀虫剂费用（元）：</th>
					<td><input type="text" name="drugfee" class="text" value="${binFlyline.drugfee}"/></td>
				</tr>
				<tr>
					<th>防尘和过滤口罩等防护用品（元）：</th>
					<td><input type="text" name="protective" class="text" value="${binFlyline.protective}"/></td>
					<th>药剂使用补助（元）：</th>
					<td><input type="text" name="subsidy" class="text" value="${binFlyline.subsidy}"/></td>
				</tr>
				<tr>
					<th>施药时长（小时）：</th>
					<td><input type="text" name="keeplong" class="text" value="${binFlyline.keeplong}"/></td>
					<th>劳务费用（元）：</th>
					<td><input type="text" name="laborfee" class="text" value="${binFlyline.laborfee}"/></td>
				</tr>
				<tr>
					<th>其他（元）：</th>
					<td colspan="3"><input type="text" name="otherfee"
						class="text" value="${binFlyline.otherfee}"/></td>
				</tr>
			</table>

			<table class="input tabContent">
<!-- 				空仓杀虫 -->
				<tr><th> 施药方式：</th> <td colspan="3"><input type="text" name="applymethod" class="text" style="width:90%;" value="${binFlyline.applymethod}"/></td></tr>
<!-- 				<tr> -->
<!-- 					<th>施药方式：</th> -->
<!-- 					<td colspan="3"><textarea name="applymethod" -->
<%-- 							style="width: 300px; height: 50px;" class="text" value="${binFlyline.applymethod}"></textarea> --%>
<!-- 				</tr> -->
				<tr>
					<th>粮面处理（g/m2）：</th>
					<td colspan="3"><input type="text" name="applyonsurface"
						class="text" value="${binFlyline.applyonsurface}"/></td>
				</tr>
				<tr><th> 其他处理方式：</th> <td colspan="3"><input type="text" name="otherdeal" class="text" style="width:90%;" value="${binFlyline.otherdeal}"/></td></tr>
<!-- 				<tr> -->
<!-- 					<th>其他处理方式：</th> -->
<!-- 					<td colspan="3"><textarea name="otherdeal" -->
<%-- 							style="width: 300px; height: 50px;" class="text" value="${binFlyline.otherdeal}"></textarea> --%>
<!-- 				</tr> -->
				<tr>
					<th>施药时温度(℃)：</th>
					<td colspan="3"><input type="text" name="avggraintemperature"
						class="text" value="${binFlyline.avggraintemperature}"/></td>
				</tr>
			</table>

			<table class="input tabContent">
				<!--  防治效果  -->
				<tr>
					<th>施药前虫口密度：</th>
					<td><input type="text" name="densitybef" class="text" value="${binFlyline.densitybef}"/></td>
					<th>主要虫种：</th>
					<td><input type="text" name="kindbef" class="text" value="${binFlyline.kindbef}"/></td>
				</tr>
				<tr>
					<th>施药后虫口密度（头/m2） ：</th>
					<td colspan="3"><input type="text" name="densityafter" class="text" value="${binFlyline.densityafter}"/></td>
				</tr>
				<tr>
					<th>无虫期间隔（天）：</th>
					<td colspan="3"><input type="text" name="noninsects"
						class="text" value="${binFlyline.noninsects}"/></td>
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