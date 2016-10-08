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
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {
	var $inputForm = $("#inputForm");
	// 表单验证
	$inputForm.validate({
		rules: {
			pass: {
				pattern: /^[^\s&\"<>]+$/,
				minlength: 4,
				maxlength: 20
			},
			rePass: {
				equalTo: "#pass"
			},
		},
 		submitHandler: function() {
 			var formData = new FormData($( "#inputForm" )[0]); 
 			var data=$("#inputForm").serialize();
 			data = data.replace(/\+/g," ");   // g表示对整个字符串中符合条件的都进行替换
			$.ajax({
				url : 'editInvestor',
				data : data,
				dataType : 'json',
/*  				contentType: false,  
		        processData: false,   */
				success : function(r) {
					if (r && r.success) {
						parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
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
<body class="easyui-layout">
	<div data-options="region:'center',border:false" title="个人信息管理 > 修改个人信息  ">
		<form id="inputForm"  method="post" enctype="multipart/form-data">
			<table class="input tabContent">
				<tr>
					<th> 用户名：</th> 
					<td>${user.username}
						<input type="hidden" name="username" value="${user.username}">
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th>密码：</th>  -->
<!-- 					<td> -->
<!-- 						<input id="password" type="password" name="password"  class="text"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>确认密码：</th> -->
<!-- 					<td> -->
<!-- 						<input type="password" name="rePass" class="text"/> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr>
					<th> 真实姓名：</th>
					<td>
						<input type="text" name="realname" class="text" value="${user.realname}" />
					</td>
				</tr>
				<tr>
					<th> 职称：</th>
					<td>
						<input type="text" name="title" class="text" value="${user.title}" />
					</td>
				</tr>
				<tr>
					<th>手机：</th>
					<td>
						<input type="text" name="moblie" class="text" value="${user.moblie}" />
					</td>
				</tr>
				<tr>
<!-- 					<td style="text-align:right;">公&nbsp;司</td> -->
					<th>公司：</th>
					<td><input id="company" type="text" class="text" name="company" class="myinput" value="${user.company}"/></td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton"
								plain="false" onclick="doAdd()" iconCls="icon-save">保存</a>
<!-- 						<a href="javascript:void(0)" class="easyui-linkbutton" -->
<!-- 								plain="false" onclick="goback()" iconCls="icon-back">返回</a> -->
					</td>
				</tr>	
			</table>							
		</form>
	</div>
</body>
</html>