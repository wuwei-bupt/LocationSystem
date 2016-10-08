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
				url : 'editBinInertaerosol',//$("#inputForm").attr("action"),
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
				'<input type="text" name="TBinInsectses[' + indexInsect + '].kinds" class="insects">' + '</td>' +  
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].density" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].damageloc" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].foundloc" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].startinsectsdate" class="insects" >' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].startkilldate" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].endkilldate" class="insects" >' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].noninsectsdate" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].killdifficultlevel" class="insects">' + '</td>' +
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
				'<input type="text" name="TBinUseDrugs[' + indexDrug + '].drugname" class="drugs">' + '</td>' +  
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].factory" class="drugs">' + '</td>' +
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].usemethod" class="drugs">' + '</td>' +
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].protectkind" class="drugs" >' + '</td>' +
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].value" class="drugs">' + '</td>' +
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;惰性粉气溶胶防治效果调查明细表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm }"/>
			<input type="hidden" name="lcbm" value="${lcbm}"/>
			<input type="hidden" name="id" value="${binInertaerosol.id}"/>
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
			<table class="input tabContent">
				<tr><th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td></tr>
				<tr><th> 粮库编号：</th> <td>${lkbm} <th><span class="lcbm">*</span> 年 度</th><td colspan="3"><input type="text" name="annual" value="${binInertaerosol.annual}"></td></tr>
				<tr><th> 填报人：</th><td><input type="text" name="reporter" class="text" value="${binInertaerosol.reporter}"/></td><th> 联系电话：</th><td><input type="text" name="phone" class="text" value="${binInertaerosol.phone}"/></td></tr>
				<tr><th> 开始日期：</th><td><input type="text" name="startdate" class="text" value="${binInertaerosol.startdate}"/></td><th> 结束日期：</th><td><input type="text" name="enddate" class="text" value="${binInertaerosol.enddate}"/></td></tr>
				<tr><th> 施药方法及设施：</th><td><input type="text" name="deviceandbrand" class="text" value="${binInertaerosol.annual}"/></td><th> 药剂厂家：</th><td><input type="text" name="factory" class="text" value="${binInertaerosol.annual}"/></td></tr>
				<tr>
					<th> 录入人：</th><td>${Inertaerosol.modifier}</td>
					<th> 录入日期：</th><td>${Inertaerosol.modifydate}</td>
				</tr>
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

			<table class="input tabContent"> <!-- 成本核算 -->
				<tr><th> 施粉器械（元）：</th><td><input type="text" name="device" class="text" value="${binInertaerosol.device}"/></td><th> 惰性粉药剂（品牌）：</th><td><input type="text" name="brand" class="text" value="${binInertaerosol.brand}"/></td></tr>
				<tr><th> 惰性粉用量（kg）：</th><td><input type="text" name="dosage" class="text" value="${binInertaerosol.dosage}"/></td><th> 惰性粉费用（元）：</th><td><input type="text" name="drugfee" class="text" value="${binInertaerosol.drugfee}"/></td></tr>
				<tr><th> 防尘和过滤口罩等防护用品（元）：</th><td><input type="text" name="protective" class="text" value="${binInertaerosol.protective}"/></td><th> 使用补助（元）：</th><td><input type="text" name="subsidy" class="text" value="${binInertaerosol.subsidy}"/></td></tr>
				<tr><th> 施粉时长（小时）：</th><td><input type="text" name="keeplong" class="text" value="${binInertaerosol.keeplong}"/></td><th> 劳务费用（元）：</th><td><input type="text" name="laborfee" class="text" value="${binInertaerosol.laborfee}"/></td></tr>
				<tr><th> 其他（元）：</th><td><input type="text" name="otherfee" class="text" value="${binInertaerosol.otherfee}"/></td></tr>
				
				
			</table>

			<table class="input tabContent"> <!-- 防护杀虫 -->
				<tr><th> 施粉方式：</th><td><input type="text" name="applymethod" class="text" value="${binInertaerosol.applymethod}"/></td></tr>
				<tr><th> 粮面施粉(mg/kg)：</th><td><input type="text" name="applyonsurface" class="text" value="${binInertaerosol.applyonsurface}"/></td><th> 分层施粉(mg/kg)：</th><td><input type="text" name="applyeverylayer" class="text" value="${binInertaerosol.applyeverylayer}"/></td></tr>
				<tr><th> 整仓施粉(mg/kg)：</th><td><input type="text" name="applyonwhole" class="text" value="${binInertaerosol.applyonwhole}"/></td><th> 粮面处理（g/m2）：</th><td><input type="text" name="dealonsurface" class="text" value="${binInertaerosol.dealonsurface}"/></td></tr>
				<tr><th> 其他处理方式：</th><td><input type="text" name="otherdeal" class="text" value="${binInertaerosol.otherdeal}"/></td></tr>
				<tr><th> 施粉时平均粮温(℃)：</th><td><input type="text" name="avggraintemperature" class="text" value="${binInertaerosol.avggraintemperature}"/></td></tr>
				<tr><th> 施粉时最高粮温(℃)：</th><td><input type="text" name="highestgraintemperature" class="text" value="${binInertaerosol.highestgraintemperature}"/></td><th> 施粉时最低粮温(℃)：</th><td><input type="text" name="lowestgraintemperature" class="text" value="${binInertaerosol.lowestgraintemperature}"/></td></tr>
				
			</table>
			
			<table class="input tabContent"> <!-- 防治效果 -->
				<tr><th> 施药前虫口密度：</th><td><input type="text" name="densitybef" class="text" value="${binInertaerosol.densitybef}"/></td><th> 主要虫种：</th><td><input type="text" name="kindbef" class="text" value="${binInertaerosol.kindbef}"/></td></tr>
				<tr><th> 施药后虫口密度：</th><td><input type="text" name="densityafter" class="text" value="${binInertaerosol.densityafter}"/></td><th> 主要虫种：</th><td><input type="text" name="kindbef" class="text" value="${binInertaerosol.kindbef}"/></td></tr>
				<tr><th> 无虫期间隔（天）：</th><td><input type="text" name="noninsects" class="text" value="${binInertaerosol.noninsects}"/></td></tr>
				
			</table>
			
			<table id="drugsTable" class="input tabContent">
				<tr><th> 脂肪酸值（防治害虫前）：</th><td><input type="text" name="fattyvaluebef" class="text" value="${binInertaerosol.fattyvaluebef}"/></td><th> 脂肪酸值（防治害虫后）：</th><td><input type="text" name="fattyvalueafter" class="text" value="${binInertaerosol.fattyvalueafter}"/></td></tr>
				<tr><th> 粉剂残留(mg/kg)：</th><td><input type="text" name="residues" class="text" value="${binInertaerosol.residues}"/></td><th> 其他：</th><td><input type="text" name="elsecharacter" class="text" value="${binInertaerosol.elsecharacter}"/></td></tr>
				
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