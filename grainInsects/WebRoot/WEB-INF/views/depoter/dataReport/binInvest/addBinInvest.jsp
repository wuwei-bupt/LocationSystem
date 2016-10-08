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
				url : 'addBinInvest',//$("#inputForm").attr("action"),
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
	var $deleteInsect = $("a.deleteInsect");
	var indexInsect = 0;
	// 增加insects
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
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].endkilldate" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].noninsectsdate" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].killdifficultlevel" class="insects">' + '</td>' +
			'<td> ' +
				'<a href="javascript:;" class="deleteInsect" style="width:50px,align:left" >[ 删除 ]</a>' +
			'</td> ' +
		'</tr>';
		$insectsTable.append(trHtml);
		indexInsect ++;
	});
	
	// 删除insects
	$deleteInsect.live("click", function() {
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
	var indexDrug = 0;
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
			<input type="hidden" name="lcbm" value="${lcbm}"/>
			<input type="hidden" name="annual" value="${annual}"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="害虫信息" />
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
			</ul>			
			<table class="input tabContent">				
				<tr><th> 粮库名称：</th> <td> ${lkmc}</td><th> 粮库编号：</th> <td>${lkbm}</td></tr>
				<tr><th> 粮仓编号：</th> <td>${lcbm}</td> <th>年份：</th><td>${annual}</td> </tr>
				<tr><th> 仓型：</th><td>  ${typebin} </td><th> 设计容量：</th><td>${capacity} </td></tr>
				<tr><th> 设计单仓容量：</th><td>  ${designcapacity} </td><th> 设计粮堆高度：</th><td>${designgrainheapheight} </td></tr>
				<tr><th><span class="requiredField">*</span>填报人：</th><td><input type="text" name="reporter" class="text" /></td><th> 填报日期：</th><td><input type="text" name="reportdate" class="easyui-datebox"/></td></tr>
				<tr><th> 联系电话：</th><td><input type="text" name="phone" class="text"/></td></tr>
			</table>
			
			<table  id="insectsTable" class="input tabContent"> <!-- 害虫信息 -->
				<tr>
					<td colspan="10">
						<a href="javascript:;" id="addInsects" class="button">增加害虫信息</a>
					</td>
				</tr>
				<tr class="title"><th>序号</th><th>虫种名称</th><th>密度</th><th>危害物</th><th>主要发生部位</th><th>起虫日期</th><th>杀虫起日期起</th><th>杀虫起日期止</th><th>无虫期</th><th>杀死难度等级</th><td><td></tr>
			</table>

			
			<table class="input tabContent"> <!-- 防治技术 -->
				<tr><th>害虫预防：</th><td>防虫网<input type="checkbox" name="TBinProtect[0].flynet">&nbsp;,&nbsp;
										     <span class="requiredField">*</span>防虫线<input type="checkbox" name="TBinProtect[0].flyline">&nbsp;,&nbsp;
										     防护剂<input type="checkbox" name="TBinProtect[0].protectant">&nbsp;,&nbsp;
										     惰性粉<input type="checkbox" name="TBinProtect[0].inertpowder">&nbsp;,&nbsp;
										     清洁卫生<input type="checkbox" name="TBinProtect[0].sanitary">&nbsp;,&nbsp;
										     密封<input type="checkbox" name="TBinProtect[0].isolateprotect">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="TBinProtect[0].otherpreprotectway">&nbsp;,&nbsp;</td></tr>
				<tr><th>害虫除治：</th><td>熏蒸杀虫<input type="checkbox" name="TBinProtect[0].fumigation">&nbsp;,&nbsp;
										     气调杀虫<input type="checkbox" name="TBinProtect[0].controlledatmosphere">&nbsp;,&nbsp;
										     冷冻杀虫<input type="checkbox" name="TBinProtect[0].frozen">&nbsp;,&nbsp;
										     高温杀虫<input type="checkbox" name="TBinProtect[0].highertemperature">&nbsp;,&nbsp;
										     辐射杀虫<input type="checkbox" name="TBinProtect[0].radiation">&nbsp;,&nbsp;
										     生物防治<input type="checkbox" name="TBinProtect[0].biologicalcontrol">&nbsp;,&nbsp;
										     器械除虫<input type="checkbox" name="TBinProtect[0].insecticidaldevice">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="TBinProtect[0].otherkillway">&nbsp;,&nbsp;</td></tr>
				<tr><th>熏蒸施药方法：</th><td>发生器<input type="checkbox" name="TBinProtect[0].generator">&nbsp;,&nbsp;
										     仓内<input type="checkbox" name="TBinProtect[0].inbin">&nbsp;,&nbsp;
										     施药器<input type="checkbox" name="TBinProtect[0].giver">&nbsp;,&nbsp;
										     通风道口<input type="checkbox" name="TBinProtect[0].fancrossing">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="TBinProtect[0].othergiveway">&nbsp;,&nbsp;</td></tr>
				<tr><th>害虫检测技术：</th><td><span class="requiredField">*</span>人工筛检<input type="checkbox" name="TBinProtect[0].artificialscreening">&nbsp;,&nbsp;
										     探管诱捕器<input type="checkbox" name="TBinProtect[0].carbontubetrap">&nbsp;,&nbsp;
										     波纹纸板诱捕器<input type="checkbox" name="TBinProtect[0].corrugatedpapertraps">&nbsp;,&nbsp;
										     频振灯诱捕<input type="checkbox" name="TBinProtect[0].frequencyvibrationlighttrap">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="TBinProtect[0].otherdetectway">&nbsp;,&nbsp;</td></tr>	
					     
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
			</table> 
			
			<table class="input tabContent"> <!-- 仓储预防管理措施 -->
				<tr><th>入库前的管理：</th><td>入库前仓房的清理、检查和整修：<input type="checkbox" name="TBinPreprotect[0].checkbeforeinput">&nbsp;,&nbsp;
										     空仓杀虫<input type="checkbox" name="TBinPreprotect[0].clearbinkill">&nbsp;,&nbsp;
										     粮食出库完毕后的清理<input type="checkbox" name="TBinPreprotect[0].checkafteroutput">&nbsp;,&nbsp;
										   </td></tr>
				<tr><th>粮油接收的管理：</th><td>入库质量检验<input type="checkbox" name="TBinPreprotect[0].inputcheck">&nbsp;,&nbsp;
										     破碎率<input type="text" name="TBinPreprotect[0].breakagerate">&nbsp;,&nbsp;
										     水分<input type="text" name="TBinPreprotect[0].watercontent">&nbsp;,&nbsp;
										     不完善粒<input type="text" name="TBinPreprotect[0].noperfect">&nbsp;,&nbsp;
										     杂质<input type="text" name="TBinPreprotect[0].impurity">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="TBinPreprotect[0].acceptelse">&nbsp;,&nbsp;</td></tr>
				<tr><th>粮油储藏期间的管理：</th><td> 防虫网<input type="checkbox" name="TBinPreprotect[0].flynet">&nbsp;,&nbsp;
										     防虫线<input type="checkbox" name="TBinPreprotect[0].flyline">&nbsp;,&nbsp;
										     害虫检查频率<input type="text" name="TBinPreprotect[0].detectfrequency">&nbsp;,&nbsp;
				<tr><th>害虫检测方法：</th><td>直观检查法<input type="checkbox" name="TBinPreprotect[0].direct">&nbsp;,&nbsp;
										     取样检查法<input type="checkbox" name="TBinPreprotect[0].sample">&nbsp;,&nbsp;
										     诱集检查法<input type="checkbox" name="TBinPreprotect[0].trap">&nbsp;,&nbsp;
										     其他&nbsp;<input type="text" name="TBinPreprotect[0].elsedetect">&nbsp;,&nbsp;</td></tr>						     
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