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
				url : 'editDepotCleankill',//$("#inputForm").attr("action"),
				data : data, //$("#inputForm").serialize(),
				dataType : 'json',
/*  				contentType: false,  
		        processData: false,   */
				success : function(r) {
					if (r && r.success) {
						parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
						goback();					} else {
						parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
					}
				}
			});
		} 
	});
	
	var $insectsTable = $("#insectsTable");
	var $addInsects = $("#addInsects");
	var $deleteBin = $("a.deleteInsect");
	var indexInsect = '${indexInsect}';
	// 增加粮仓
	$addInsects.click(function() {
		var trHtml = 
			'<tr>' +
 				'<td>' + indexInsect + '</td><td>' +
					'<input type="text" name="TDepotsInsectses[' + indexInsect + '].kinds" class="insects">' + '</td>' +  
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].density" class="insects">' + '</td>' +
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].damagegrain" class="insects">' + '</td>' +
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].foundloc" class="insects">' + '</td>' +
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].startinsectsdate" class="insects" >' + '</td>' +
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].startkilldate" class="insects">' + '</td>' +
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].endkilldate" class="insects" >' + '</td>' +
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].noninsectsdate" class="insects">' + '</td>' +
				'<td >' + '<input type="text" name="TDepotsInsectses[' + indexInsect + '].killdifficultlevel" class="insects">' + '</td>' +
				'<td> ' +
					'<a href="javascript:;" class="deleteInsect" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$insectsTable.append(trHtml);
		indexInsect ++;
	});
	
	// 删除粮仓
	$deleteBin.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该害虫记录吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
 	var $drugsTable = $("#drugsTable");
	var $addDrugs = $("#addDrugs");
	var $deleteDrug = $("a.deleteDrug");
	var indexDrug =  '${indexDrug}';
	// 增加药剂/
	$addDrugs.click(function() {
		var trHtml = 
			'<tr>' +
 				'<td>' + indexDrug + '</td><td>' +
					'<input type="text" name="TDepotUseDrugs[' + indexDrug + '].drugname" class="drugs">' + '</td>' +  
				'<td >' + '<input type="text" name="TDepotUseDrugs[' + indexDrug + '].factory" class="drugs">' + '</td>' +
				'<td >' + '<input type="text" name="TDepotUseDrugs[' + indexDrug + '].usemethod" class="drugs">' + '</td>' +
				'<td >' + '<input type="text" name="TDepotUseDrugs[' + indexDrug + '].protectkind" class="drugs" >' + '</td>' +
				'<td >' + '<input type="text" name="TDepotUseDrugs[' + indexDrug + '].value" class="drugs">' + '</td>' +
				'<td> ' +
					'<a href="javascript:;" class="deleteDrug" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
			
		$drugsTable.append(trHtml);
		indexDrug ++;
	});
	
	// 删除药剂
	$deleteDrug.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该药剂记录吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
	
	$("table input[type=checkbox]").each(function(){
		//console.info($(this).val() + '  ' + $(this).attr("name"));
			if ($(this).val())
				$(this).attr("checked",true);
			else
				$(this).attr("checked",false);
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;空仓杀虫储粮害虫防治调查汇总表
		<form id="inputForm"  method="post"  enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm}"/>
			<input type="hidden" name="id" value="${depotCleankill.id}"/>
			<input type="hidden" name="reportdate" value="${depotCleankill.reportdate}"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="成本核算" />
				</li>
				<li>
					<input type="button" value="空仓杀虫" />
				</li>
				<li>
					<input type="button" value="防治效果" />
				</li> 
				<li>
					<input type="button" value="意见及建议" />
				</li> 
			</ul>
			<!-- 基本情况 -->		
			<table class="input tabContent">
				<tr><th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td></tr>
				<tr><th> 粮库编号：</th> <td>${lkbm} </td>
				<tr><th><span class="requiredField">*</span> 年 度：</th><td colspan="3"><input type="text" name="annual" value="${depotCleankill.annual}"></td></tr>
				<tr><th> 填报人：</th><td><input type="text" name="reporter" class="text" value="${depotCleankill.reporter}"/></td><th> 联系电话：</th><td><input type="text" class="text" name="phone" value="${depotCleankill.phone}"/></td></tr>
				<tr><th> 填表日期：</th><td><input type="text" name="reportdate" class="easyui-datebox" value="${depotCleankill.reportdate}"/></td></tr>
				<tr><th> 空仓杀虫剂名称：</th><td><input type="text" class="text" name="drug" value="${depotCleankill.drug}"/></td><th> 施药设施及方法：</th><td><input type="text" name="deviceandway" class="text" value="${depotCleankill.deviceandway}"/></td></tr>
				<tr><th> 空仓杀虫剂使用规模（吨/年）：</th><td><input type="text" name="totaluse" value ="${depotCleankill.totaluse}" class="text"/></td><th> 使用空仓杀虫剂的仓房比例（%）：</th><td><input type="text" name="proportion" value="${depotCleankill.proportion}" class="text"/></td></tr>
				<tr><th> 录入人：</th><td>${depotCleankill.modifier}</td><th> 录入日期：</th><td>${depotCleankill.modifydate}</td></tr>
			</table>
		    <!-- 成本核算 -->
			<table class="input tabContent">
				<tr><th> 施药器械（元）：</th><td><input type="text" name="device" class="text" value="${depotCleankill.device}"/></td><th>空仓杀虫剂药剂（品牌）：</th><td><input type="text" name="brand" class="text" value="${depotCleankill.brand}"/></td> </tr>
				<tr><th> 空仓杀虫剂用量（kg）：</th><td><input type="text" name="dosage" class="text" value="${depotCleankill.dosage}"/></td><th> 空仓杀虫剂费用（元）：</th><td><input type="text" name="drugfee" class="text" value="${depotCleankill.drugfee}"/></td></tr>
				<tr><th> 防尘和过滤口罩等防护用品（元）：</th><td><input type="text" name="protective" class="text" value="${depotCleankill.protective}"/></td><th> 药剂使用补助（元）：</th><td><input type="text" name="subsidy" class="text" value="${depotCleankill.subsidy}"/></td></tr>
				<tr><th> 平均施药时长（小时）：</th><td><input type="text" name="keeplong" class="text" value="${depotCleankill.keeplong}"/></td><th> 劳务费用（元）：</th><td><input type="text" name="laborfee" class="text" value="${depotCleankill.laborfee}"/></td></tr>		
				<tr><th> 其它（元）：</th><td><input type="text" name="otherfee" class="text" value="${depotCleankill.otherfee}"/></td></tr>
			</table>
			<!-- 空仓杀虫 -->
			<table class="input tabContent">
				<tr><th> 施药方式：</th> <td><input type="text" name="applymethod" class="text" value="${depotCleankill.applymethod}"/></td></tr>
				<tr><th> 粮面处理（g/m2）：</th> <td><input type="text" name="applyonsurface" class="text" value="${depotCleankill.applyonsurface}" /></td></tr>
				<tr><th> 其他处理方式：</th><td><input type="text" name="otherdeal" class="text" value="${depotCleankill.otherdeal}" /></td></tr>
				<tr><th> 施药时温度(℃)：</th><td><input type="text" name="avggraintemperature" class="text" value="${depotCleankill.avggraintemperature}"/></td></tr>
			</table>
			<!-- 防治效果 -->
			<table class="input tabContent">
				<tr><th> 施药前虫口密度：</th> <td><input type="text" name="densitybef" class="text" value="${depotCleankill.densitybef}" /></td><th> 主要虫种：</th> <td><input type="text" name="kindbef" class="text" value="${depotCleankill.kindbef}" /></td></tr>
				<tr><th> 施药后虫口密度（头/m2）：</th> <td><input type="text" name="densityafter" class="text" value="${depotCleankill.densityafter}" /></td><th> 主要虫种：</th> <td><input type="text" class="text" name="kindaf" value="${depotCleankill.kindaf}"/></td></tr>
				<tr><th> 无虫期间隔（天）：</th><td><input type="text" name="noninsects" class="text" value="${depotCleankill.noninsects}" /></td></tr>
			</table>
			<!-- 意见及建议 -->
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="editor" class="editor" name="suggestion"  style="width: 98%;">${depotCleankill.suggestion}</textarea>
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