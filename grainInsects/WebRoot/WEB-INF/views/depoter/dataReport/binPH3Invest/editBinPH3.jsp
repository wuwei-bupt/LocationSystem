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
				url : 'editBinPhosphinefumigation',//$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;磷化氢熏蒸储粮害虫防治效果调查汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lcbm" value="${lcbm}"/>
			<input type="hidden" name="annual" value="${binPhosphinefumigation.annual}"/>
			<input type="hidden" name="id" value="${binPhosphinefumigation.id}"/>
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
					<input type="button" value="熏蒸杀虫" />
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
					<th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td></tr>
				<tr>
					<th> 粮库编号：</th> <td>${lkbm}</td>
					<th> 年度</th><td>${binPhosphinefumigation.annual}</td>
				</tr>
				<tr>
					<th> 填报人：</th><td><input type="text" name="reporter" class="text" value="${binPhosphinefumigation.reporter}"/></td>
					<th> 联系电话：</th><td><input type="text" name="phone" class="text" value="${binPhosphinefumigation.phone}"/></td>
				</tr>
				<tr>
					<th> 填表日期：</th><td><input type="text" name="reportdate" class="easyui-datebox" value="${binPhosphinefumigation.reportdate}"/></td>
				</tr>
				<tr>
					<th> 录入人：</th><td>${binPhosphinefumigation.modifier}</td>
					<th> 录入日期：</th><td>${binPhosphinefumigation.modifytime}</td>
				</tr>
				<tr>
					<th> 熏蒸开始日期：</th><td><input type="text" name="startdate" class="easyui-datebox" value="${binPhosphinefumigation.startdate}"/></td>
					<th> 熏蒸结束日期：</th><td><input type="text" name="enddate"  class="easyui-datebox" value="${binPhosphinefumigation.enddate}"/></td>
				</tr>
				<tr>
					<th> 是否环流：</th> <td><input type="text" name="" class="text"/></td>
					<th> 熏蒸设施：</th> <td><input type="text" name="" class="text"/></td>
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
					<th> 环流风机及系统（元）：</th><td><input type="text" name="fansys" class="text" value="${binPhosphinefumigation.fansys}"/></td>
					<th> 磷化铝药剂（品牌）：</th><td><input type="text" name="brand" class="text" value="${binPhosphinefumigation.brand}"/></td>
				</tr>
				<tr>
					<th>磷化铝药剂用量（kg）：</th><td><input type="text" name="Dosage" class="text" value="${binPhosphinefumigation.dosage}"/></td>
					<th>磷化铝药剂费用（元）：</th><td><input type="text" name="drugfee" class="text" value="${binPhosphinefumigation.drugfee}"/></td>
				</tr>
				<tr>
					<th>空气呼吸器（元）：</th><td><input type="text" name="breathing" class="text" value="${binPhosphinefumigation.breathing}"/></td>
					<th>药剂使用补助（元）：</th><td><input type="text" name="subsidy" class="text" value="${binPhosphinefumigation.subsidy}"/></td>
				</tr>
				<tr>
					<th>空气充气泵（元）：</th><td><input type="text" name="pump" class="text" value="${binPhosphinefumigation.pump}"/></td>
					<th>槽管、压条、薄膜及施工费（元）：</th><td><input type="text" name="otherfee" class="text" value="${binPhosphinefumigation.otherfee}"/></td>
				</tr>
				<tr>
					<th>磷化氢报警仪（元）：</th><td><input type="text" name="alarmer" class="text" value="${binPhosphinefumigation.alarmer}"/></td>
					<th>电费（元）：</th><td><input type="text" name="powerfee" class="text" value="${binPhosphinefumigation.powerfee}"/></td>
				</tr>
				<tr>
					<th>磷化氢检测仪（元）：</th><td><input type="text" name="detecter" class="text" value="${binPhosphinefumigation.detecter}"/></td>
					<th>其他（元）：</th><td><input type="text" name="elsefee" class="text" value="${binPhosphinefumigation.elsefee}"/></td>
				</tr>
			</table>

			
			<table class="input tabContent"> <!-- 熏蒸杀虫 -->
				<tr>
					<th>累计熏蒸时间（天）:</th><td><input type="text" name="totaldays" class="text" value="${binPhosphinefumigation.totaldays}"/></td>
					<th>环流方式：</th><td><input type="text" name="circulationway" class="text" value="${binPhosphinefumigation.circulationway}"/></td>
				</tr>
				<tr>
					<th>平均最高浓度(mL/m3)：</th><td><input type="text" name="highestppm" class="text" value="${binPhosphinefumigation.highestppm}"/></td>
					<th>目标熏蒸浓度维持时间：</th><td><input type="text" name="targetdays" class="text" value="${binPhosphinefumigation.targetdays}"/></td>
				</tr>
				<tr>
					<th>熏蒸时平均粮温（℃）：</th><td><input type="text" name="avgtemperature" class="text" value="${binPhosphinefumigation.avgtemperature}"/></td>
					<th>施药方法：</th>
					<td>
						发生器<input type="checkbox" name="Generator" value="${binPhosphinefumigation.generator}"/>
						仓内<input type="checkbox" name="inbin" value="${binPhosphinefumigation.inbin}"/>
						施药器<input type="checkbox" name="giver" value="${binPhosphinefumigation.giver}"/>
						通风道口<input type="checkbox" name="fancrossing" value="${binPhosphinefumigation.fancrossing}"/>
						其他<input type="text" name="othergiveway" value="${binPhosphinefumigation.othergiveway}" class="text"/></td>
					</td>
				</tr>
				<tr>
					<th>熏蒸时最高粮温（℃）：</th><td><input type="text" name="highesttemperature" class="text" value="${binPhosphinefumigation.highesttemperature}"/></td>
					<th>熏蒸时最低粮温（℃）：</th><td><input type="text" name="lowesttemperature" class="text" value="${binPhosphinefumigation.lowesttemperature}"/></td>
				</tr>
					     
			</table>
			
			<table class="input tabContent"><!-- 防治效果 -->
				<tr>
					<th>熏蒸前虫口密度：</th><td><input type="text" name="densitybefca" class="text" value="${binPhosphinefumigation.densitybefca}"/></td>
					<th>主要虫种：</th><td><input type="text" name="kindbefca" class="text" value="${binPhosphinefumigation.kindbefca}"/></td>
				</tr>
				<tr>
					<th>熏蒸平均浓度范围：</th><td><input type="text" name="varconcentration" class="text" value="${binPhosphinefumigation.varconcentration}"/></td>
					<th>熏蒸后活虫密度及虫种：</th><td><input type="text" name="densityafterca" class="text" value="${binPhosphinefumigation.densityafterca}"/></td>
				</tr>
				<tr>
					<th>无虫间隔（天）：</th><td><input type="text" name="noninsects" class="text" value="${binPhosphinefumigation.noninsects}"/></td>
					<th>是否放置虫笼（虫源）及虫种：</th><td><input type="text" name="densityafterca" class="text" value="${binPhosphinefumigation.densityafterca}"/></td>
				</tr>
				<tr>
					<th>虫笼中虫口数量（熏蒸前）：</th><td><input type="text" name="cagenum" class="text" value="${binPhosphinefumigation.cagenum}"/></td>
					<th>虫笼中有无活口（熏蒸后）：</th><td><input type="text" name="hasliveInsectsafter" class="text" value="${binPhosphinefumigation.hasliveInsectsafter}"/></td>
				</tr>
			</table> 
			
			<table class="input tabContent"> <!-- 品质变化 -->
				<tr>
					<th>脂肪酸值（防治害虫前）：</th><td><input type="text" name="fattyvaluebef" class="text" value="${binPhosphinefumigation.fattyvaluebef}"/></td>
					<th>脂肪酸值（气调防治害虫前）：</th><td><input type="text" name="fattyvalueafter" class="text" value="${binPhosphinefumigation.fattyvalueafter}"/></td>
				</tr>	
				<tr>
					<th>其他：</th><td><input type="text" name="elsecharacter" class="text" value="${binPhosphinefumigation.elsecharacter}"/></td>
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