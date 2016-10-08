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
				url : 'addDepotPhosphinefumigation',//$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;磷化氢熏蒸储粮害虫防治效果调查汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm}"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
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
				<li>
					<input type="button" value="意见与建议" />
				</li> 
			</ul>			
			<table class="input tabContent"><!-- 基本情况 -->			
				<tr>
					<th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td></tr>
				<tr>
					<th> 粮库编号：</th> <td>${lkbm}</td>
					<th><span class="requiredField">*</span> 年度</th><td><input type="text" name="Annual" class="text"/ ></td>
				</tr>
				<tr>
					<th> 填报人：</th><td><input type="text" name="reporter" class="text"/></td>
					<th> 联系电话：</th><td><input type="text" name="phone" class="text"/></td>
				</tr>
				<tr>
					<th> 填表日期：</th><td><input type="text" name="reportdate" class="easyui-datebox"/></td>
				</tr>
				<tr>
					<th> 熏蒸规模（吨/年）：</th><td><input type="text" name="cascale" class="text" /></td>
					<th> 熏蒸粮食比例（%）：</th><td><input type="text" name="proportion"  class="text" /></td>
				</tr>
				<tr>
					<th> 熏蒸设施：</th> <td><input type="text" name="device" class="text"/></td>
					<th> 是否环流：</th> <td><input type="text" name="ifcirculation" class="text"/></td>
				</tr>
			</table>
			
			<table class="input tabContent"> <!-- 成本核算 -->
				<tr>
					<th> 环流风机及系统（元）：</th><td><input type="text" name="fansys" class="text"/></td>
					<th> 磷化铝药剂（品牌）：</th><td><input type="text" name="brand" class="text"/></td>
				</tr>
				<tr>
					<th>磷化铝药剂用量（kg）：</th><td><input type="text" name="Dosage" class="text"/></td>
					<th>磷化铝药剂费用（元）：</th><td><input type="text" name="drugfee" class="text"/></td>
				</tr>
				<tr>
					<th>空气呼吸器（元）：</th><td><input type="text" name="breathing" class="text"/></td>
					<th>药剂使用补助（元）：</th><td><input type="text" name="subsidy" class="text"/></td>
				</tr>
				<tr>
					<th>空气充气泵（元）：</th><td><input type="text" name="pump" class="text"/></td>
					<th>槽管、压条、薄膜及施工费（元）：</th><td><input type="text" name="otherfee" class="text"/></td>
				</tr>
				<tr>
					<th>磷化氢报警仪（元）：</th><td><input type="text" name="alarmer" class="text"/></td>
					<th>电费（元）：</th><td><input type="text" name="powerfee" class="text"/></td>
				</tr>
				<tr>
					<th>磷化氢检测仪（元）：</th><td><input type="text" name="detecter" class="text"/></td>
					<th>其他：</th><td><input type="text" name="elsefee" class="text"/></td>
				</tr>
			</table>

			
			<table class="input tabContent"> <!-- 熏蒸杀虫 -->
				<tr>
					<th>平均熏蒸时间（天）:</th><td><input type="text" name="" class="text" /></td>
					<th>环流方式：</th><td><input type="text" name="circulationway" class="text" /></td>
				</tr>
				<tr>
					<th>平均最高浓度(mL/m3)：</th><td><input type="text" name="highestppm" class="text" /></td>
					<th>目标熏蒸浓度维持时间：</th><td><input type="text" name="targetdays" class="text" /></td>
				</tr>
				<tr>
					<th>熏蒸时平均粮温（℃）：</th><td><input type="text" name="avgtemperature" class="text" /></td>
					<th>施药方法：</th>
					<td>
						发生器<input type="checkbox" name="Generator"/>
						仓内<input type="checkbox" name="inbin" />
						施药器<input type="checkbox" name="giver"/>
						通风道口<input type="checkbox" name="fancrossing"/>
						其他<input type="text" name="othergiveway" class="text"/></td>
					</td>
				</tr>
				<tr>
					<th>熏蒸时最高粮温（℃）：</th><td><input type="text" name="highesttemperature" class="text" /></td>
					<th>熏蒸时最低粮温（℃）：</th><td><input type="text" name="lowesttemperature" class="text" /></td>
				</tr>
					     
			</table>
			
			<table class="input tabContent"><!-- 防治效果 -->
				<tr>
					<th>熏蒸前虫口密度：</th><td><input type="text" name="densitybefca" class="text" /></td>
					<th>主要虫种：</th><td><input type="text" name="kindbefca" class="text" /></td>
				</tr>
				<tr>
					<th>熏蒸平均浓度范围：</th><td><input type="text" name="varconcentration" class="text" /></td>
					<th>熏蒸后活虫密度及虫种：</th><td><input type="text" name="densityafterca" class="text" /></td>
				</tr>
				<tr>
					<th>无虫间隔（天）：</th><td><input type="text" name="noninsects" class="text" /></td>
					<th>是否放置虫笼（虫源）及虫种：</th><td><input type="text" name="ifcage" class="text" /></td>
				</tr>
				<tr>
					<th>虫笼中虫口数量（熏蒸前）：</th><td><input type="text" name="cagenum" class="text" /></td>
					<th>虫笼中有无活口（熏蒸后）：</th><td><input type="text" name="hasliveInsectsafter" class="text" /></td>
				</tr>
			</table> 
			
			<table class="input tabContent"> <!-- 品质变化 -->
				<tr>
					<th>脂肪酸值（防治害虫前）：</th><td><input type="text" name="fattyvaluebef" class="text" /></td>
					<th>脂肪酸值（气调防治害虫前）：</th><td><input type="text" name="fattyvalueafter" class="text" /></td>
				</tr>	
				<tr>
					<th>其他：</th><td><input type="text" name="elsecharacter" class="text" /></td>
				</tr>	     
			</table>
			<table class="input tabContent"> <!-- 意见与建议 -->
				<tr>
					<td>
						<textarea id="editor" name="suggestion" class="editor" style="width: 98%;"></textarea>
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