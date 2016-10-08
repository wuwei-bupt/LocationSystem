<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {
	var typeData = [{
		value:'0',
		type:'害虫识别'
	},{
		value:'1',
		type:'害虫防治'
	},{
		value:'2',
		type:'其他'
	}];
	$('#type').combobox({
		data:typeData,
	    valueField:'value',
	    textField:'type'
	  });
	$('#type').combobox('select', '${expertopinion.optype}');

	<c:forEach var="depot" items="${expertopinion.grainDepots}">
		
		$('#lkbm').combobox('select', '${depot.lkbm}');
	</c:forEach>
	
	
	
	
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
				url : 'editIdea',//$("#inputForm").attr("action"),
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
 	doEdit = function(){
		$("#inputForm").submit();
	};
	
	goback = function(){
		window.history.back();
	};

</script>	
</head>
<body class="easyui-layout">
	<div data-options="region:'center',border:false" title="监测预报 > 专家意见 > 编辑" style="">
		<div class="container" >
			<form id="inputForm"    method="post" enctype="multipart/form-data">		
				<table class="input tabContent"><!-- 基本情况 -->	
					<input type='text' name='id' value='${ id }' hidden/>		
					<tr>
						<th> 专家：</th> <td>${expert.name}</td>
					</tr>
					<tr>
						<th> <span class="requiredField">*</span>粮库：</th>
						<td>
							<input name="lkbms[]" value="" hidden>
							<input id='lkbm' name="lkbms[]" class="easyui-combobox" data-options="
								multiple:true,
								valueField: 'value',
								textField: 'text',
								data: [
								<c:forEach var="depot" items="${graindepots}">
									{
									text: '${depot.lkmc}',
									value: '${ depot.lkbm}'
									},
								</c:forEach>
								]"
								 />
						</td>
					</tr>
					<tr>
						<th> <span class="requiredField">*</span>主题：</th><td><input type="text" name="topic" class="text" value="${expertopinion.topic }"/></td>
					</tr>
					<tr>
						<th> <span class="requiredField">*</span>类型：</th>
						<td>
							<input id='type' type="text" name="optype"/>
						</td>
					</tr>
					<tr>
						<th> <span class="requiredField">*</span>意见：</th>
						<td>
							<textarea id="editor" name="opinion" class="editor" style="width: 98%;">${expertopinion.opinion }</textarea>
						</td>
					</tr>	
				</table>
				<table class="input">
					<tr><th>&nbsp;</th>
					<td >
					<!--  <input type="submit" class="button" value="save" /> -->
					<a href="javascript:void(0)" class="easyui-linkbutton"
							plain="false" onclick="doEdit()" iconCls="icon-save">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
							plain="false" onclick="goback()" iconCls="icon-back">返回</a>
					</td>
					</tr>	
				</table>							
			</form>
		</div>
	</div>
</body>
</html>