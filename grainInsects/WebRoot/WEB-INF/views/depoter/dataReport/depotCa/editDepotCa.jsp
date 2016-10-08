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
	$("table input[type=checkbox]").each(function(){
			if ($(this).val() == 1)
				$(this).attr('checked','checked');
		});
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
				url : 'editDepotCa',//$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;氮气气调储粮害虫防治效果调查汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm }"/>
			<input type="hidden" name="id" value="${depotCa.id }"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="成本核算" />
				</li> 
				<li>
					<input type="button" value="气调储粮" />
				</li> 
				<li>
					<input type="button" value="防治效果" />
				</li> 
				<li>
					<input type="button" value="品质变化" />
				</li> 
				<li>
					<input type="button" value="意见与建议" />
				</li> 
			</ul>			
			<table class="input tabContent"> <!-- 基本情况 -->
				<tr><th> 粮库名称：</th> <td> ${lkmc}</td><th> 粮库编号：</th> <td>${lkbm} <td></tr>
				<tr><th><span class="requiredField">*</span> 年 度</th><td><input type="text" name="annual" value="${depotCa.annual}"></td><th>填报时间:</th><td><input type="text" class="easyui-datebox" name="reportdate" value="${depotCa.reportdate}"/></td></tr>
				<tr><th> 建设规模（吨）：</th><td><input type="text" name="cascale" class="text" value="${depotCa.cascale}"/></td>
					<th> 气调建设时间 ：</th><td><input type="text" name="finishdate"  class="text" value="${depotCa.finishdate}"/></td></tr>
				<tr><th> 制氮设备厂家（各厂家间以逗号隔开）：</th> <td colspan="3"><input type="text" name="factory" style="width:90%;" value="${depotCa.factory}"/></td></tr>
				<tr><th>制氮设备运行是否正常 ：</th> <td><input type="checkbox" name="ifnormalrun" value="${depotCa.ifnormalrun}"></td>
					<th>制氮设备存在问题及原因 ：</th> <td><input type="text" name = "problem" class = "text" value = "${depotCa.problem}"/></td></tr>
				<tr><th>管道是否压力测试  ：</th> <td><input type="checkbox" name="iftest" value = "${depotCa.iftest}"></td>
					<th>智能控制系统是否正常使用  ：</th> <td><input type="checkbox" name="intelligentifnoraluse" value="${depotCa.intelligentifnoraluse}"></td></tr>
				<tr><th> 主供气管道材质 ：</th><td><input type="text" name="material" class="text" value = "${depotCa.material}"/></td>
					<th> 智能控制系统建设规模 ：</th><td><input type="text" name="intelligentscale"  class="text" value = "${depotCa.intelligentscale}"/></td></tr>
				<tr><th>录入人：</th><td>${depotCa.modifier}</td><th>录入日期：</th><td>${depotCa.modifytime}</td></tr>	
				<tr><th> 填报人：</th><td><input type="text" name="reporter" class="text" value="${depotCa.reporter}"/></td>
					<th> 联系电话：</th><td><input type="text" name="phone" class="text" value="${depotCa.phone}"/></td></tr>
			</table>
			
			<table class="input tabContent"> <!-- 成本核算 -->
				<tr><th><span class="requiredField">*</span> 制氮设备（元） ：</th><td><input type="text" name="nitrogendevice" value = "${depotCa.nitrogendevice}"></td>
					<th> 气调智能控制系统（元）：</th><td><input type="text" name="controlsystem" class="text" value = "${depotCa.controlsystem}"/></td></tr>
				<tr><th> 空气压缩机（元）：</th><td><input type="text" name="aircompressor" class="text" value = "${depotCa.aircompressor}"/></td>
					<th> 制氮机房（元）：</th><td><input type="text" name="nitrogenroom"  class="text" value = "${depotCa.nitrogenroom}"/></td></tr>
				<tr><th> 空气呼吸器（元）：</th><td><input type="text" name="respirator" class="text" value = "${depotCa.respirator}"/></td>
					<th> 管道及施工费（元）：</th><td><input type="text" name="pipleandfee"  class="text" value = "${depotCa.pipleandfee}"/></td></tr>
				<tr><th> 空气充气泵（元）：</th><td><input type="text" name="airpump" class="text" value = "${depotCa.airpump}"/></td>
					<th> 电缆及施工费（元）：</th><td><input type="text" name="cableandfee"  class="text" value = "${depotCa.cableandfee}"/></td></tr>
				<tr><th> 低氧报警仪（元）：</th><td><input type="text" name="hypoxiaalarm" class="text" value = "${depotCa.hypoxiaalarm}"/></td>
					<th> 电缆、槽管、压条、薄膜及施工费（元）：</th><td><input type="text" name="auxiliaryandfee"  class="text" value = "${depotCa.auxiliaryandfee}"/></td></tr>
				<tr><th> 氧气浓度检测仪（元）：</th><td><input type="text" name="oxygendetectdevice" class="text" value = "${depotCa.oxygendetectdevice}"/></td>
					<th> 电费（元）：</th><td><input type="text" name="electricityfee"  class="text" value = "${depotCa.electricityfee}"/></td></tr>
			</table>
			
			<table class="input tabContent"> <!-- 气调储粮 -->
				<tr><th> 平均充气时间（h） ：</th><td><input type="text" name="chargetime" value = "${depotCa.chargetime}"></td>
					<th> 充气工艺 ：</th><td><input type="text" name="chargepro" class="text" value = "${depotCa.chargepro}"/></td></tr>
				<tr><th><span class="requiredField">*</span> 平均最高浓度(%) ：</th><td><input type="text" name="maxconcentration" class="text" value = "${depotCa.maxconcentration}"/></td>
					<th> 目标浓度维持时间（h）：</th><td><input type="text" name="keeplong"  class="text" value = "${depotCa.keeplong}"/></td></tr>
				<tr><th> 充氮时平均粮温(°C) ：</th><td><input type="text" name="avggraintemperature" class="text" value = "${depotCa.avggraintemperature}"/></td>
					<th> 充氮时最高粮温(°C) ：</th><td><input type="text" name="highgraintemperature"  class="text" value = "${depotCa.highgraintemperature}"/></td></tr>
				<tr><th> 充氮时最低粮温(°C) ：</th><td><input type="text" name="lowestgraintemperture" class="text" value = "${depotCa.lowestgraintemperture}"/></td></tr>
			</table>
			
			<table class="input tabContent"> <!-- 防治效果-->
				<tr><th> 气调前虫口密度  ：</th><td><input type="text" name="densitybefca" value = "${depotCa.densitybefca}"></td>
					<th> 气调前虫种 ：</th><td><input type="text" name="kindbefca" class="text" value = "${depotCa.kindbefca}"/></td></tr>
				<tr><th> 气调后虫口密度  ：</th><td><input type="text" name="densityafterca" value = "${depotCa.densityafterca}"></td>
					<th> 气调后虫种 ：</th><td><input type="text" name="kindafterca" class="text" value = "${depotCa.kindafterca}"/></td></tr>
				<tr><th><span class="requiredField">*</span> 氮气平均浓度范围 ：</th><td><input type="text" name="varconcentration" class="text" value = "${depotCa.varconcentration}"/></td>
					<th> 无虫期间隔（天）：</th><td><input type="text" name="noninsects"  class="text" value = "${depotCa.noninsects}"/></td></tr>
			</table>
			
			<table class="input tabContent"> <!-- 品质变化 -->
				<tr><th> 脂肪酸值（防治害虫前） ：</th><td><input type="text" name="fattyacidvaluebef" value = "${depotCa.fattyacidvaluebef}"></td>
					<th> 脂肪酸值（气调防治害虫前）：</th><td><input type="text" name="fattyacidvalueafter" class="text" value = "${depotCa.fattyacidvalueafter}"/></td></tr>
				<tr><th> 其他指标 ：</th><td><input type="text" name="elsecharacter" style="width:90%;" value = "${depotCa.elsecharacter}"></td></tr>
			</table>
			
			<table class="input tabContent"> <!-- 意见与建议 -->
				<tr>
					<td>
						<textarea id="editor" name="suggestion"  style="width: 98%; "> ${depotCa.suggestion}</textarea>
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