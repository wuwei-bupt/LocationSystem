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
				url : 'editDepotInvest',//$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;粮库害虫年度调查汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm }"/>
			<input type="hidden" name="sm" value="${depotInvest.sm }"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="害虫信息" />
				</li> 
				<li>
					<input type="button" value="平均粮温" />
				</li> 
				<li>
					<input type="button" value="环境温度" />
				</li> 
				<li>
					<input type="button" value="环境湿度" />
				</li> 
				<li>
					<input type="button" value="防治技术" />
				</li> 
				<li>
					<input type="button" value="常用药剂" />
				</li> 
				<li>
					<input type="button" value="仓储预防管理措施" />
				</li> 
				<li>
					<input type="button" value="意见与建议" />
				</li> 
			</ul>			
			<table class="input tabContent">
				<tr><th> 粮库名称：</th> <td> ${lkmc}</td><th>填报时间</th><td><input type="text" value="${depotInvest.reportdate}" class="easyui-datebox" name="reportdate"/></td></tr>
				<tr><th> 粮库编号：</th> <td>${lkbm} <th> 地址：</th><td>${lkdz} </td></tr>
				<tr><th> 经度：</th><td>  ${longtitude} </td><th> 纬度：</th><td>${latitude} </td></tr>
				<tr><th> 海拔：</th><td>  ${altitude} </td><th> 邮政编码：</th><td>${postcode} </td></tr>
				<tr><th><span class="requiredField">*</span> 年 度</th><td colspan="3"><input type="text" name="annual" value="${depotInvest.annual}" ></td></tr>
				<tr><th> 建设规模（吨）：</th><td><input type="text" name="constructionScale" class="text" value="${depotInvest.constructionScale}" /></td>
					<th> 储粮规模（吨）：</th><td><input type="text" name="grainScale"  class="text" value="${depotInvest.grainScale}" /></td></tr>
				<tr><th> 主要粮种（种类间以逗号隔开）：</th> <td colspan="3"><input type="text" name="maingrain" style="width:90%;" value="${depotInvest.maingrain}"  /></td></tr>
				<tr><th> 填报人：</th><td><input type="text" name="reporter" class="text" value="${depotInvest.reporter}" /></td>
				<th> 联系电话：</th><td><input type="text" name="phone" class="text" value="${depotInvest.phone}" /></td></tr>
				<tr><th>录入人：</th><td>${depotInvest.modifer}</td><th>录入时间</th><td>${depotInvest.modifydate}</td></tr>
			</table>
			
			<table id="insectsTable" class="input tabContent">
				<tr>
					<td colspan="10">
						<a href="javascript:;" id="addInsects" class="button">增加害虫信息</a>
					</td>
				</tr>
				<tr class="title">
					<td >序号</td>
					<td >虫种名称</td>
					<td >密度(条/kg)</td>
					<td >危害物</td>
					<td >主要发生部位</td>
					<td >起虫日期</td>
					<td >杀虫日期起</td>
					<td >杀虫日期止</td>
					<td >无虫期(天)</td>
					<td >杀死难度等级</td>
				</tr>
				<c:forEach var="insects" items="${depotInvest.TDepotsInsectses}" varStatus="status">
					<tr><td>${status.index}</td>
						<input type="hidden" name="TDepotsInsectses[${status.index}].sm" value="${insects.sm}" />
						<td><input type="text" name="TDepotsInsectses[${status.index}].kinds" value="${insects.kinds}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].density" value="${insects.density}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].damagegrain" value="${insects.damagegrain}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].foundloc" value="${insects.foundloc}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].startinsectsdate" value="${insects.startinsectsdate}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].startkilldate" value="${insects.startkilldate}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].endkilldate" value="${insects.endkilldate}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].noninsectsdate" value="${insects.noninsectsdate}" class="insects"/></td>
						<td><input type="text" name="TDepotsInsectses[${status.index}].killdifficultlevel" value="${insects.killdifficultlevel}" class="insects"/></td>
						<td>
							<a href="javascript:;" class="deleteInsect">[ 删除 ]</a>
						</td>
					</tr>				
				</c:forEach>
			</table> 
			
			<table class="input tabContent"> <!-- 平均粮温 -->
				<tr><td><input type="hidden" name="depotGraintemperatures[0].id" value="${depotInvest.depotGraintemperatures[0].id}" /></td></tr><!-- old primary key -->
				<tr><th>1月</th><td><input type="text" name="depotGraintemperatures[0].january" value="${depotInvest.depotGraintemperatures[0].january}"></td> 
				<th>2月</th><td><input type="text" name="depotGraintemperatures[0].february" value="${depotInvest.depotGraintemperatures[0].february}"></td> <tr>
				<tr><th>3月</th><td><input type="text" name="depotGraintemperatures[0].march" value="${depotInvest.depotGraintemperatures[0].march}"></td> 
				<th>4月</th><td><input type="text" name="depotGraintemperatures[0].april" value="${depotInvest.depotGraintemperatures[0].april}"></td> <tr>
				<tr><th>5月</th><td><input type="text" name="depotGraintemperatures[0].may" value="${depotInvest.depotGraintemperatures[0].may}"></td> 
				<th>6月</th><td><input type="text" name="depotGraintemperatures[0].june" value="${depotInvest.depotGraintemperatures[0].june}"></td> <tr>
				<tr><th>7月</th><td><input type="text" name="depotGraintemperatures[0].july" value="${depotInvest.depotGraintemperatures[0].july}"></td> 
				<th>8月</th><td><input type="text" name="depotGraintemperatures[0].august" value="${depotInvest.depotGraintemperatures[0].august}"></td> <tr>
				<tr><th>9月</th><td><input type="text" name="depotGraintemperatures[0].september" value="${depotInvest.depotGraintemperatures[0].september}"></td> 
				<th>10月</th><td><input type="text" name="depotGraintemperatures[0].october" value="${depotInvest.depotGraintemperatures[0].october}"></td> <tr>
				<tr><th>11月</th><td><input type="text" name="depotGraintemperatures[0].november" value="${depotInvest.depotGraintemperatures[0].november}"></td> 
				<th>12月</th><td><input type="text" name="depotGraintemperatures[0].december" value="${depotInvest.depotGraintemperatures[0].december}"></td> <tr>
			</table>

			<table class="input tabContent"> <!-- 环境温度 -->
				<tr><td><input type="hidden" name="TDepoEnvitemperatures[0].id" value="${depotInvest.TDepoEnvitemperatures[0].id}" /></td></tr><!-- old primary key -->
				<tr><th>1月</th><td><input type="text" name="TDepoEnvitemperatures[0].january" value="${depotInvest.TDepoEnvitemperatures[0].january}"></td> 
				<th>2月</th><td><input type="text" name="TDepoEnvitemperatures[0].february" value="${depotInvest.TDepoEnvitemperatures[0].february}"></td> <tr>
				<tr><th>3月</th><td><input type="text" name="TDepoEnvitemperatures[0].march" value="${depotInvest.TDepoEnvitemperatures[0].march}"></td> 
				<th>4月</th><td><input type="text" name="TDepoEnvitemperatures[0].april" value="${depotInvest.TDepoEnvitemperatures[0].april}"></td> <tr>
				<tr><th>5月</th><td><input type="text" name="TDepoEnvitemperatures[0].may" value="${depotInvest.TDepoEnvitemperatures[0].may}"></td> 
				<th>6月</th><td><input type="text" name="TDepoEnvitemperatures[0].june" value="${depotInvest.TDepoEnvitemperatures[0].june}"></td> <tr>
				<tr><th>7月</th><td><input type="text" name="TDepoEnvitemperatures[0].july" value="${depotInvest.TDepoEnvitemperatures[0].july}"></td> 
				<th>8月</th><td><input type="text" name="TDepoEnvitemperatures[0].august" value="${depotInvest.TDepoEnvitemperatures[0].august}"></td> <tr>
				<tr><th>9月</th><td><input type="text" name="TDepoEnvitemperatures[0].september" value="${depotInvest.TDepoEnvitemperatures[0].september}"></td> 
				<th>10月</th><td><input type="text" name="TDepoEnvitemperatures[0].october" value="${depotInvest.TDepoEnvitemperatures[0].october}"></td> <tr>
				<tr><th>11月</th><td><input type="text" name="TDepoEnvitemperatures[0].november" value="${depotInvest.TDepoEnvitemperatures[0].november}"></td> 
				<th>12月</th><td><input type="text" name="TDepoEnvitemperatures[0].december" value="${depotInvest.TDepoEnvitemperatures[0].december}"></td> <tr>
			</table>

			<table class="input tabContent"> <!-- 环境湿度 -->
				<tr><td><input type="hidden" name="TDepotHumidities[0].id" value="${depotInvest.TDepotHumidities[0].id}" /></td></tr><!-- old primary key -->
				<tr><th>1月</th><td><input type="text" name="TDepotHumidities[0].january"  value="${depotInvest.TDepotHumidities[0].january}"></td> 
				<th>2月</th><td><input type="text" name="TDepotHumidities[0].february" value="${depotInvest.TDepotHumidities[0].february}"></td> <tr>
				<tr><th>3月</th><td><input type="text" name="TDepotHumidities[0].march" value="${depotInvest.TDepotHumidities[0].march}"></td> 
				<th>4月</th><td><input type="text" name="TDepotHumidities[0].april" value="${depotInvest.TDepotHumidities[0].april}"></td> <tr>
				<tr><th>5月</th><td><input type="text" name="TDepotHumidities[0].may" value="${depotInvest.TDepotHumidities[0].may}"></td> 
				<th>6月</th><td><input type="text" name="TDepotHumidities[0].june" value="${depotInvest.TDepotHumidities[0].june}"></td> <tr>
				<tr><th>7月</th><td><input type="text" name="TDepotHumidities[0].july" value="${depotInvest.TDepotHumidities[0].july}"></td> 
				<th>8月</th><td><input type="text" name="TDepotHumidities[0].august" value="${depotInvest.TDepotHumidities[0].august}"></td> <tr>
				<tr><th>9月</th><td><input type="text" name="TDepotHumidities[0].september" value="${depotInvest.TDepotHumidities[0].september}"></td> 
				<th>10月</th><td><input type="text" name="TDepotHumidities[0].october" value="${depotInvest.TDepotHumidities[0].october}"></td> <tr>
				<tr><th>11月</th><td><input type="text" name="TDepotHumidities[0].november" value="${depotInvest.TDepotHumidities[0].november}"></td> 
				<th>12月</th><td><input type="text" name="TDepotHumidities[0].december" value="${depotInvest.TDepotHumidities[0].december}"></td> <tr>
			</table>
			
			<table class="input tabContent"> <!-- 防治技术 -->
				<tr><td><input type="hidden" name="depotProtects[0].sm" value="${depotInvest.depotProtects[0].sm}" /></td></tr><!-- old primary key -->
				<tr><th>害虫预防：</th><td>防虫网<input type="checkbox" name="depotProtects[0].flynet" value="${depotInvest.depotProtects[0].flynet}">&nbsp;,&nbsp;
										     防虫线<input type="checkbox" name="depotProtects[0].flyline" value="${depotInvest.depotProtects[0].flyline}">&nbsp;,&nbsp;
										     防护剂<input type="checkbox" name="depotProtects[0].protectant" value="${depotInvest.depotProtects[0].protectant}">&nbsp;,&nbsp;
										     惰性粉<input type="checkbox" name="depotProtects[0].inertpowder" value="${depotInvest.depotProtects[0].inertpowder}">&nbsp;,&nbsp;
										     清洁卫生<input type="checkbox" name="depotProtects[0].sanitary" value="${depotInvest.depotProtects[0].sanitary}">&nbsp;,&nbsp;
										     密封<input type="checkbox" name="depotProtects[0].isolateprotect" value="${depotInvest.depotProtects[0].isolateprotect}">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="depotProtects[0].otherpreprotectway" value="${depotInvest.depotProtects[0].otherpreprotectway}">&nbsp;,&nbsp;</td></tr>
				<tr><th>害虫除治：</th><td>熏蒸杀虫<input type="checkbox" name="depotProtects[0].fumigation" value="${depotInvest.depotProtects[0].fumigation}">&nbsp;,&nbsp;
										     气调杀虫<input type="checkbox" name="depotProtects[0].controlledatmosphere" value="${depotInvest.depotProtects[0].controlledatmosphere}">&nbsp;,&nbsp;
										     冷冻杀虫<input type="checkbox" name="depotProtects[0].frozen" value="${depotInvest.depotProtects[0].frozen}">&nbsp;,&nbsp;
										     高温杀虫<input type="checkbox" name="depotProtects[0].highertemperature" value="${depotInvest.depotProtects[0].highertemperature}">&nbsp;,&nbsp;
										     辐射杀虫<input type="checkbox" name="depotProtects[0].radiation" value="${depotInvest.depotProtects[0].radiation}">&nbsp;,&nbsp;
										     生物防治<input type="checkbox" name="depotProtects[0].biologicalcontrol" value="${depotInvest.depotProtects[0].biologicalcontrol}">&nbsp;,&nbsp;
										     器械除虫<input type="checkbox" name="depotProtects[0].insecticidaldevice" value="${depotInvest.depotProtects[0].insecticidaldevice}">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="depotProtects[0].otherkillway" value="${depotInvest.depotProtects[0].otherkillway}">&nbsp;,&nbsp;</td></tr>
				<tr><th>熏蒸施药方法：</th><td>发生器<input type="checkbox" name="depotProtects[0].generator" value="${depotInvest.depotProtects[0].generator}">&nbsp;,&nbsp;
										     仓内<input type="checkbox" name="depotProtects[0].inbin" value="${depotInvest.depotProtects[0].inbin}">&nbsp;,&nbsp;
										     施药器<input type="checkbox" name="depotProtects[0].giver" value="${depotInvest.depotProtects[0].giver}">&nbsp;,&nbsp;
										     通风道口<input type="checkbox" name="depotProtects[0].fancrossing" value="${depotInvest.depotProtects[0].fancrossing}">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="depotProtects[0].othergiveway" value="${depotInvest.depotProtects[0].othergiveway}">&nbsp;,&nbsp;</td></tr>
				<tr><th>害虫检测技术：</th><td>人工筛检<input type="checkbox" name="depotProtects[0].artificialscreening" value="${depotInvest.depotProtects[0].artificialscreening}">&nbsp;,&nbsp;
										     探管诱捕器<input type="checkbox" name="depotProtects[0].carbontubetrap" value="${depotInvest.depotProtects[0].carbontubetrap}">&nbsp;,&nbsp;
										     波纹纸板诱捕器<input type="checkbox" name="depotProtects[0].corrugatedpapertraps" value="${depotInvest.depotProtects[0].corrugatedpapertraps}">&nbsp;,&nbsp;
										     频振灯诱捕<input type="checkbox" name="depotProtects[0].frequencyvibrationlighttrap" value="${depotInvest.depotProtects[0].frequencyvibrationlighttrap}">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="depotProtects[0].otherdetectway" value="${depotInvest.depotProtects[0].otherdetectway}">&nbsp;,&nbsp;</td></tr>						     
			</table>
			
			<table id="drugsTable" class="input tabContent">
				<tr>
					<td colspan="10">
						<a href="javascript:;" id="addDrugs" class="button">增加药剂信息</a>
					</td>
				</tr>
				<tr class="title">
					<td >序号</td>
					<td >药剂名称/剂型</td>
					<td >厂家</td>
					<td >施药措施及方法</td>
					<td >防治方法类型</td>
					<td >用量（kg）</td>
				</tr>
				<c:forEach var="useDrug" items="${depotInvest.TDepotUseDrugs}" varStatus="status">
					<tr><td>${status.index}</td>
						<input type="hidden" name="TDepotUseDrugs[${status.index}].sm" value="${useDrug.sm}" />
						<td><input type="text" name="TDepotUseDrugs[${status.index}].drugname" value="${useDrug.drugname}" class="drugs"/></td>
						<td><input type="text" name="TDepotUseDrugs[${status.index}].factory" value="${useDrug.factory}" class="drugs"/></td>
						<td><input type="text" name="TDepotUseDrugs[${status.index}].usemethod" value="${useDrug.usemethod}" class="drugs"/></td>
						<td><input type="text" name="TDepotUseDrugs[${status.index}].protectkind" value="${useDrug.protectkind}" class="drugs"/></td>
						<td><input type="text" name="TDepotUseDrugs[${status.index}].value" value="${useDrug.value}" class="drugs"/></td>
						<td>
							<a href="javascript:;" class="deleteDrug">[ 删除 ]</a>
						</td>
					</tr>				
				</c:forEach>				
			</table> 
			
			<table class="input tabContent"> <!-- 仓储预防管理措施 -->
				<tr><td><input type="hidden" name="depotPreprotects[0].sm" value="${depotInvest.depotPreprotects[0].sm}" /></td></tr><!-- old primary key -->
				<tr><th>入库前的管理：</th><td>入库前仓房的清理、检查和整修：<input type="checkbox" name="depotPreprotects[0].checkbeforeinput" value="${depotInvest.depotPreprotects[0].checkbeforeinput}">&nbsp;,&nbsp;
										     空仓杀虫<input type="checkbox" name="depotPreprotects[0].clearbinkill" value="${depotInvest.depotPreprotects[0].clearbinkill}">&nbsp;,&nbsp;
										     粮食出库完毕后的清理<input type="checkbox" name="depotPreprotects[0].checkafteroutput" value="${depotInvest.depotPreprotects[0].checkafteroutput}">&nbsp;,&nbsp;
										   </td></tr>
				<tr><th>粮油接收的管理：</th><td>入库质量检验<input type="checkbox" name="depotPreprotects[0].inputcheck" value="${depotInvest.depotPreprotects[0].inputcheck}">&nbsp;,&nbsp;
										     破碎率<input type="text" name="depotPreprotects[0].breakagerate" value="${depotInvest.depotPreprotects[0].breakagerate}">&nbsp;,&nbsp;
										     水分<input type="text" name="depotPreprotects[0].watercontent" value="${depotInvest.depotPreprotects[0].watercontent}">&nbsp;,&nbsp;
										     不完善粒<input type="text" name="depotPreprotects[0].noperfect" value="${depotInvest.depotPreprotects[0].noperfect}">&nbsp;,&nbsp;
										     杂质<input type="text" name="depotPreprotects[0].impurity" value="${depotInvest.depotPreprotects[0].impurity}">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="depotPreprotects[0].acceptelse" value="${depotInvest.depotPreprotects[0].acceptelse}">&nbsp;,&nbsp;</td></tr>
				<tr><th>粮油储藏期间的管理：</th><td> 防虫网<input type="checkbox" name="depotPreprotects[0].flynet" value="${depotInvest.depotPreprotects[0].flynet}">&nbsp;,&nbsp;
										     防虫线<input type="checkbox" name="depotPreprotects[0].flyline" value="${depotInvest.depotPreprotects[0].flyline}">&nbsp;,&nbsp;
										     害虫检查频率<input type="text" name="depotPreprotects[0].detectfrequency" value="${depotInvest.depotPreprotects[0].detectfrequency}">&nbsp;,&nbsp;
				<tr><th>害虫检测方法：</th><td>直观检查法<input type="checkbox" name="depotPreprotects[0].direct" value="${depotInvest.depotPreprotects[0].direct}">&nbsp;,&nbsp;
										     取样检查法<input type="checkbox" name="depotPreprotects[0].sample" value="${depotInvest.depotPreprotects[0].sample}">&nbsp;,&nbsp;
										     诱集检查法<input type="checkbox" name="depotPreprotects[0].trap" value="${depotInvest.depotPreprotects[0].trap}">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="depotPreprotects[0].elsedetect" value="${depotInvest.depotPreprotects[0].elsedetect}">&nbsp;,&nbsp;</td></tr>						     
			</table>
			
			<table class="input tabContent">
				<tr>
					<td>
						<textarea id="editor" name="suggestion"  style="width: 98%; "> ${depotInvest.suggestion}</textarea>
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