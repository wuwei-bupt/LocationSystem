<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
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
	KindEditor.ready(function(K) {
		editor = K.create("#editor",{
			readonlyMode:true
		});
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
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="专家意见 > 详情" style="overflow: hidden;">
		<div class="container" >
			<br>&nbsp;&nbsp;&nbsp;&raquo;专家意见表
			<form id="inputForm"    method="post" enctype="multipart/form-data">		
				<table class="input tabContent"><!-- 基本情况 -->		
					<tr>
						<th> 专家：</th> <td>${expertopinion.expert.name}</td>
					</tr>
					<tr>
						<th>
						粮库：
						</th>
						<td>
							<c:forEach var="depot" items="${expertopinion.grainDepots}">
								${depot.lkmc},
							</c:forEach>
						</td>
					</tr>
					
					<tr>
						<th> 主题：</th><td>${expertopinion.topic }</td>
					</tr>
					<tr>
						<th> 类型：</th>
						<td>
							<c:if test="${expertopinion.optype == 0}">
							 	害虫识别
							</c:if>
							<c:if test="${expertopinion.optype == 1}">
							 	害虫防治
							</c:if>
							<c:if test="${expertopinion.optype == 2}">
							 	其他
							</c:if>
						</td>
					</tr>
					<tr>
						<th> 意见：</th>
						<td>
						${expertopinion.opinion }
						</td>
					</tr>
				</table>
				<table class="input">
					<tr><th>&nbsp;</th>
					<td >
		
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