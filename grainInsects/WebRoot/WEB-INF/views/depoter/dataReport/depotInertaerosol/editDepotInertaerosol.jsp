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
				url : 'editDepotInertaerosol' , //$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;惰性气溶胶调查汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm }"/>
			<input type="hidden" name="id" value="${depotInertaerosol.id }"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
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
				<li>
					<input type="button" value="意见及建议" />
				</li> 
			</ul>			
			<!-- 基本情况 -->		
			<table class="input tabContent">

				<tr><th> 粮库名称：</th> <td> ${lkmc}</td><th> 粮库编号：</th> <td>${lkbm} </td></tr>
				<tr><th><span class="requiredField">*</span> 年 度：</th><td><input type="text" name="annual" value="${depotInertaerosol.annual}"></td><th>填报时间：</th><td><input type="text" class="easyui-datebox" name="reportdate" value="${depotInertaerosol.reportdate}"/></td></tr>
				<tr><th> 填报人：</th><td><input type="text" name="reporter" class="text" value="${depotInertaerosol.reporter}"/></td><th> 联系电话：</th><td><input type="text" class="text" name="phone" value="${depotInertaerosol.phone}" /></td></tr>
				<tr><th>录入人：</th><td>${depotInertaerosol.modifier}</td><th>录入时间：</th><td>${depotInertaerosol.modifydate}</td></tr>
				<tr><th> 惰性粉气溶胶名称：</th><td><input type="text" class="text" name="drug" value="${depotInertaerosol.drug}"/></td></tr>
				<tr><th> 惰性粉气溶胶使用规模（吨/年）：</th><td><input type="text" name="totaluse" class="text" value="${depotInertaerosol.totaluse}"/></td><th> 使用惰性粉气溶胶的粮食比例（%）：</th><td><input type="text" name="proportion" class="text" value="${depotInertaerosol.proportion}"/></td></tr>
				<tr><th> 施粉设施及方法：</th><td><input type="text" class="text" name="deviceandway" value="${depotInertaerosol.deviceandway}"/></td></tr>
				
			</table>
		    <!-- 成本核算 -->
			<table class="input tabContent">
				<tr><th> 施粉器械（元）：</th><td><input type="text" name="device" class="text" value="${depotInertaerosol.device}"/></td><th>惰性粉气溶胶药剂（品牌）：</th><td><input type="text" name="brand" class="text" value="${depotInertaerosol.brand}"/></td> </tr>
				<tr><th> 惰性粉气溶胶用量（kg）：</th><td><input type="text" name="dosage" class="text" value="${depotInertaerosol.dosage}"/></td><th> 惰性粉气溶胶费用（元）：</th><td><input type="text" name="drugfee" class="text" value="${depotInertaerosol.drugfee}"/></td></tr>
				<tr><th> 防尘和过滤口罩等防护用品（元）：</th><td><input type="text" name="protective" class="text" value="${depotInertaerosol.protective}"/></td><th> 粉剂使用补助（元）：</th><td><input type="text" name="subsidy" class="text" value="${depotInertaerosol.subsidy}"/></td></tr>
				<tr><th> 劳务费用（元）：</th><td><input type="text" name="laborfee" class="text" value="${depotInertaerosol.laborfee}"/></td><th> 其它（元）：</th><td><input type="text" name="otherfee" class="text" value="${depotInertaerosol.otherfee}"/></td></tr>
			</table>
			<!-- 防护杀虫 -->
			<table class="input tabContent">
				<tr><th> 施粉方式：</th> <td><input type="text" name="applymethod" class="text"  value="${depotInertaerosol.applymethod}"/></td></tr>
				<tr><th> 粮面施粉(mg/kg)：</th> <td><input type="text" name="applyonsurface" class="text"  value="${depotInertaerosol.applyonsurface}"/></td><th> 分层施粉(mg/kg)：</th> <td><input type="text" name="applyeverylayer" class="text" value="${depotInertaerosol.applyeverylayer}" /></td></tr>
				<tr><th> 整仓施粉(mg/kg)：</th> <td><input type="text" name="applyonwhole" class="text"  value="${depotInertaerosol.applyonwhole}"/></td><th> 粮面处理(g/m2)：</th> <td><input type="text" name="dealonsurface" class="text" value="${depotInertaerosol.dealonsurface}" /></td></tr>
				<tr><th> 其他处理方式：</th><td><input type="text" name="otherdeal" class="text"  value="${depotInertaerosol.otherdeal}" /></td></tr>
				<tr><th> 施粉时平均粮温(℃)：</th><td><input type="text" name="avggraintemperature" class="text" value="${depotInertaerosol.avggraintemperature}"/></td></tr>
				<tr><th> 施粉时最高粮温(℃)：</th><td><input type="text" name="highestgraintemperature" class="text" value="${depotInertaerosol.highestgraintemperature}"/></td><th> 施粉时最低粮温(℃)：</th><td><input type="text" name="lowestgraintemperature" class="text" value="${depotInertaerosol.lowestgraintemperature}"/></td></tr>
			</table>
			
			<!-- 防治效果 -->
			<table class="input tabContent">
				<tr><th> 施粉前虫口密度：</th> <td><input type="text" name="densitybef" class="text"  value="${depotInertaerosol.densitybef}"/></td><th> 主要虫种：</th> <td><input type="text" name="kindbef" class="text" value="${depotInertaerosol.kindbef}" /></td></tr>
				<tr><th> 施粉后虫口密度（头/m2）：</th> <td><input type="text" name="densityafter" class="text"  value="${depotInertaerosol.densityafter}"/></td><th> 主要虫种：</th> <td><input type="text" name="kindbef" class="text"  value="${depotInertaerosol.kindbef}"/></td></tr>
				<tr><th> 无虫期间隔（天）：</th><td><input type="text" name="noninsects" class="text"  value="${depotInertaerosol.noninsects}"/></td></tr>
			</table>
			<!-- 品质变化 -->
			<table class="input tabContent">
				<tr><th> 脂肪酸值（防治害虫前）：</th><td><input type="text" name="fattyvaluebef" class="text" value="${depotInertaerosol.fattyvaluebef}"/></td><th> 脂肪酸值（防治害虫后）：</th><td><input type="text" name="fattyvalueafter" class="text" value="${depotInertaerosol.fattyvalueafter}"/></td></tr>
				<tr><th> 粉剂残留(mg/kg)：</th><td><input type="text" name="residues" class="text" value="${depotInertaerosol.residues}"/></td><th> 其他：</th><td><input type="text" name="elsecharacter" class="text" value="${depotInertaerosol.elsecharacter}"/></td></tr>
				
			</table>
			<!-- 意见及建议 -->
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="editor" class="editor" name="suggestion" style="width: 98%;">${depotInertaerosol.suggestion}</textarea>
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