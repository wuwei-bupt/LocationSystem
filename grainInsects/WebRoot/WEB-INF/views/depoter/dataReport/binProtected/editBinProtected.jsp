<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<style>
	.insects {
		width: 80px;
		height: 24px;
		padding-left: 5px;
	}
	.drugs {
		width: 180px;
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
				url : 'editBinProtected',//$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;防护剂储粮害虫防治效果调查明细表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lcbm" value="${lcbm}"/>
			<input type="hidden" name="id" value="${binProtected.id}"/>
			<input type="hidden" name="Annual" value="${binProtected.annual}"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="粮仓情况"/>
				</li>
				<li>
					<input type="button" value="储粮信息"/>
				</li>
				<li>
					<input type="button" value="成本核算" />
				</li> 
				<li>
					<input type="button" value="防护杀虫" />
				</li> 
				<li>
					<input type="button" value="防治效果" />
				</li> 
				<li>
					<input type="button" value="品质变化" />
				</li> 
			</ul>			
			<table class="input tabContent"><!-- 基本情况 -->			
				<tr>
					<th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td>
				</tr>
				<tr>
					<th> 粮库编号：</th><td>${lkbm}</td>
					<th> 年度</th><td>${binProtected.annual}</td>
				</tr>
				<tr>
					<th> 填报人：</th><td><input type="text" name="reporter" class="text" value="${binProtected.reporter}"/></td>
					<th> 联系电话：</th><td><input type="text" name="phone" class="text" value="${binProtected.phone}"/></td>
				</tr>
				<tr>
					<th> 填表日期：</th><td><input type="text" name="reportdate" class="easyui-datebox" value="${binProtected.reportdate}"/></td>
				</tr>
				<tr>
					<th> 录入人：</th><td>${binProtected.modifier}</td>
					<th> 录入日期：</th><td>${binProtected.modifydate}</td>
				</tr>
				<tr>
					<th> 开始日期：</th><td><input type="text" name="startdate" class="easyui-datebox" value="${binProtected.startdate}"/></td>
					<th> 结束日期：</th><td><input type="text" name="enddate" class="easyui-datebox" value="${binProtected.enddate}"/></td>
				</tr>
				<tr>
					<th>药剂名称</th><td><input type="text" name="" class="text"  value=""/></td>
					<th>药剂厂家</th><td><input type="text" name="factory" class="text"  value="${binProtected.factory}"/></td>
				</tr>
				<tr>
					<th> 施药方法及设施：</th> <td colspan="3"><input type="text"  class="text" name="" style="width:90%;"  value=""/></td>
				</tr>
			</table>
			<!-- 粮仓情况 -->
			<table class="input tabContent">
				<tr>
					<th> 仓型：</th><td>${typebin}</td>
					<th> 仓号：</th><td>${lcbm}</td>
				</tr>
				<tr>
					<th> 建设规模(吨)：</th><td>${capacity}</td>
					<th> 储粮规模(吨)：</th><td>${capacity}</td>
				</tr>
				<tr>
					<th> 仓长(米)：</th><td>${longth}</td>
					<th> 仓宽(米)</th><td>${width}</td>
				</tr>
				<tr>
					<th> 设计粮堆高度(米)：</th><td>${height}</td>
					<th> 仓体结构：</th><td>${structureofbody}</td>
				</tr>
				<tr>
					<th> 环流装置：</th><td>${circulatedevice}</td>
				</tr>
				<tr>
					<th> 环流风机：</th><td>${circulatefan}</td>
				</tr>
				<tr>
					<th> 仓房风道：</th><td>${fanway}</td>
				</tr>
				<tr>
					<th> 通过改善仓储条件进行害虫的预防：</th><td>${circulatedevice}</td>
				</tr>		
			</table>
			<!-- 储粮信息 -->
			<table class="input tabContent">
				<tr>
					<th> 粮种名称：</th> <td>${grain.grainname}</td>
					<th> 装粮形式：</th> <td>${grain.clxs}</td>
				</tr>
				<tr>
					<th> 收获日期：</th><td>${grain.harvestdate}</td>
					<th> 入储日期：</th> <td>${grain.indate}</td>
				</tr>
				<tr>
					<th> 水分：</th><td>${grain.water}</td>
					<th> 杂质：</th> <td>${grain.impurity}</td>
				</tr>
				<tr>
					<th> 干燥方式：</th><td>${grain.dryingmethod}</td>
					<th> 存储年限（年）：</th> <td>${grain.reserveperiod}</td>
				</tr>
				<tr>
					<th> 入储数量（吨）：</th><td>${grain.innum}</td>
					<th> 装具：</th> <td>${grain.container}</td>
				</tr>
				<tr>
					<th> 空仓500pa（秒）：</th><td>${grain.empty_bin500pa}</td>
					<th> 空仓半衰500pa（秒）：</th> <td>${grain.halfemptybin500pa}</td>
				</tr>
				<tr>
					<th> 满仓300pa（秒）：</th><td>${grain.fullbin300pa}</td>
					<th> 满仓半衰300pa（秒）：</th> <td>${grain.halffullbin}</td>
				</tr>
				<tr>
					<th> 储藏技术：</th><td>${grain.storetechnology}</td>
					<th> 储藏方式：</th> <td>${grain.storemethod}</td>
				</tr>
				<tr>
					<th> 控温措施：</th><td>${grain.controltemperaturemeasures}</td>
					<th> 控湿措施：</th> <td>${grain.controlhumiditymeasures}</td>
				</tr>
				<tr>
					<th> 来源：</th><td>${grain.source}</td>
					<th> 实际粮堆高度（米）：</th> <td>${grain.grainheight}</td>
				</tr>
			</table> 
			<table class="input tabContent"> <!-- 成本核算 -->
				<tr>
					<th> 施药器械（元）：</th><td><input type="text" name="device" class="text" value="${binProtected.device}"/></td>
					<th> 防护剂药剂（品牌）：</th><td><input type="text" name="brand" class="text" value="${binProtected.brand}"/></td>
				</tr>
				<tr>
					<th>防护剂用量（kg）：</th><td><input type="text" name="Dosage" class="text"  value="${binProtected.dosage}"/></td>
					<th>防护剂费用（元）：</th><td><input type="text" name="drugfee" class="text"  value="${binProtected.drugfee}"/></td>
				</tr>
				<tr>
					<th>防尘和过滤口罩等防护用品（元）：</th><td><input type="text" name="protective" class="text"  value="${binProtected.protective}"/></td>
					<th>药剂使用补助（元）：</th><td><input type="text" name="subsidy" class="text"  value="${binProtected.subsidy}"/></td>
				</tr>
				<tr>
					<th>施药时长（小时）：</th><td><input type="text" name="keeplong" class="text"  value="${binProtected.keeplong}"/></td>
					<th>劳务费用（元）：</th><td><input type="text" name="laborfee" class="text"  value="${binProtected.laborfee}"/></td>
				</tr>
				<tr>
					<th>其他（元）：</th><td><input type="text" name="otherfee" class="text"  value="${binProtected.otherfee}"/></td>
				</tr>
			</table>

			
			<table class="input tabContent"> <!-- 防护杀虫 -->
				<tr>
					<th>施药方式：</th><td><input type="text" name="applymethod" class="text" value="${binProtected.applymethod}"/></td>
				</tr>
				<tr>
					<th>粮面施药（mg/kg）:</th><td><input type="text" name="applyonsurface" class="text" value="${binProtected.applyonsurface}"/></td>
					<th>分层施药（mg/kg）：</th><td><input type="text" name="applyeverylayer" class="text" value="${binProtected.applyeverylayer}"/></td>
				</tr>
				<tr>
					<th>整仓拌药（mg/kg）</th><td><input type="text" name="applyonwhole" class="text" value="${binProtected.applyonwhole}"/></td>
					<th>粮面处理（g/m^2）：</th><td><input type="text" name="dealonsurface" class="text" value="${binProtected.dealonsurface}"/></td>
				</tr>
				<tr>
					<th>其他处理方式：</th><td><input type="text" name="otherdeal" class="text" value="${binProtected.otherdeal}"/></td>
				</tr>
				<tr>
					<th>施药时平均粮温（℃）：</th><td><input type="text" name="avggraintemperature" class="text" value="${binProtected.avggraintemperature}"/></td>
				</tr>
				<tr>
					<th>施药时最高粮温（℃）：</th><td><input type="text" name="highestgraintemperature" class="text" value="${binProtected.highestgraintemperature}"/></td>
					<th>施药时最低粮温（℃）：</th><td><input type="text" name="lowestgraintemperature" class="text" value="${binProtected.lowestgraintemperature}"/></td>
				</tr>
					     
			</table>
			
			<table class="input tabContent"><!-- 防治效果 -->
				<tr>
					<th>施药前虫口密度：</th><td><input type="text" name="densitybef" class="text" value="${binProtected.densitybef}"/></td>
					<th>主要虫种：</th><td><input type="text" name="kindbef" class="text" value="${binProtected.kindbef}"/></td>
				</tr>
				<tr>
					<th>施药前后虫口密度：</th><td><input type="text" name="densityafter" class="text" value="${binProtected.densityafter}"/></td>
					<th>主要虫种：</th><td><input type="text" name="" class="text" value=""/></td>
				</tr>
				<tr>
					<th>无虫间隔（天）：</th><td><input type="text" name="noninsects" class="text" value="${binProtected.noninsects}"/></td>
				</tr>
			</table> 
			
			<table class="input tabContent"> <!-- 品质变化 -->
				<tr>
					<th>脂肪酸值（防治害虫前):</th><td><input type="text" name="fattyvaluebef" class="text" value="${binProtected.fattyvaluebef}"/></td>
					<th>脂肪酸值（防治害虫前：</th><td><input type="text" name="fattyvalueafter" class="text" value="${binProtected.fattyvalueafter}"/></td>
				</tr>	
				<tr>
					<th>药剂残留（mg/kg）:</th><td><input type="text" name="residues" class="text" value="${binProtected.residues}"/></td>
					<th>其他：</th><td><input type="text" name="elsecharacter" class="text" value="${binProtected.elsecharacter}"/></td>
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