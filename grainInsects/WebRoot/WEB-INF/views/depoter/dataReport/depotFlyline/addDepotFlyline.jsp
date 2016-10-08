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
				url : 'addDepotFlyline',//$("#inputForm").attr("action"),
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;防虫线防治效果调查汇总表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lkbm" value="${lkbm }"/> 
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
					<input type="button" value="意见与建议" />
				</li> 
			</ul>
			
					
			<table class="input tabContent">      <!-- 基本情况 -->
				<tr><th> 粮库名称：</th> <td> ${lkmc}</td><th> 粮库编号：</th> <td>${lkbm}</td></tr>
				<tr><th><span class="requiredField">*</span> 年 度：</th><td><input type="text" name="annual" ></td><th>填报时间：</th><td><input type="text" name="reportdate" class="easyui-datebox"/></td></tr>
				<tr><th> 填报人：</th><td><input type="text" name="reporter" class="text"/></td><th> 联系电话：</th><td><input type="text" name="phone" class="text"/></td></tr>
				<tr><th> 防虫线杀虫剂使用规模（吨/年）：</th><td><input type="text" name="totaluse" class="text" /></td>
					<th> 使用防虫线杀虫剂的仓房比例（%）：</th><td><input type="text" name="proportion"  class="text" /></td></tr>
				<tr><th> 施药设施及方法：</th> <td colspan="3"><input type="text" name="deviceandway" class="text" style="width:90%;" /></td></tr>
			</table>
			
			<table class="input tabContent">       <!-- 成本核算 -->
				<tr><th> 施药器械（元）：</th><td><input type="text" name="device" class="text" /></td>
					<th> 防虫线杀虫剂药剂（品牌）：</th><td><input type="text" name="brand"  class="text" /></td></tr>
				<tr><th> 空仓杀虫剂用量（kg）：</th><td><input type="text" name="Dosage" class="text" /></td>
					<th> 防虫线杀虫剂费用（元）：</th><td><input type="text" name="drugfee"  class="text" /></td></tr>
				<tr><th> 防尘和过滤口罩等防护用品（元）：</th><td><input type="text" name="protective" class="text" /></td>
					<th> 药剂使用补助（元）：</th><td><input type="text" name="subsidy"  class="text" /></td></tr>
				<tr><th> 劳务费用（元）：</th><td><input type="text" name="laborfee" class="text" /></td>
					<th> 其他（元）：</th><td><input type="text" name="otherfee"  class="text" /></td></tr>
			</table>

			<table class="input tabContent"> <!-- 空仓杀虫 -->
				<tr><th> 施药方式：</th> <td colspan="3"><input type="text" name="applymethod" class="text" style="width:90%;" /></td></tr>
				<tr><th> 粮面处理（g/m2）：</th> <td colspan="3"><input type="text" name="applyonsurface" class="text" /></td></tr>
				<tr><th> 其他处理方式：</th> <td colspan="3"><input type="text" name="otherdeal" class="text" style="width:90%;" /></td></tr>
				<tr><th> 施药时温度(℃)：</th> <td colspan="3"><input type="text" name="avggraintemperature" class="text" /></td></tr>
			</table>

			<table class="input tabContent">       <!-- 防治效果 -->
				<tr><th> 施药前虫口密度：</th><td><input type="text" name="densitybef" class="text" /></td>
					<th> 主要虫种：</th><td><input type="text" name="kindbef"  class="text" /></td></tr>
				<tr><th> 施药后虫口密度（头/m2） ：</th><td colspan="3"><input type="text" name="densityafter" class="text" /></td></tr>
				<tr><th> 无虫期间隔（天）：</th> <td colspan="3"><input type="text" name="noninsects" class="text" /></td></tr>
			</table>
			
			<table class="input tabContent">
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