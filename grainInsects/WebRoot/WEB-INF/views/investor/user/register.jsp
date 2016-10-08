<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>login - Powered By Szy++</title>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />

<link href="<%=base %>resources/admin/css/common.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="<%=base %>resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%=base %>resources/admin/js/list.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>

<style type="text/css">
	.myinput {
		outline:none;	/*去掉input获得焦点时的外边框*/
		text-align:center;
		border-style:none;
		border-bottom-style:solid;
		border-bottom-width:1px;
	}
	table tr{
		line-height: 3.0;
	}
	#submit{
		background-color:#E4393C;
		width:220px;
		height:40px;
		font-size:20px;
		color:white;
	}
</style>
<script type="text/javascript">
	// 检查积分是否为数字
	function onlyNumber(event){
			var keyCode = event.keyCode;
			if ((keyCode>=48 && keyCode<=57) || (keyCode >= 96 && keyCode <= 105) || keyCode == 8){
				return true;
			}else{
				return false;
			}
		}
	$().ready(function(){
		var $registerForm = $("#registerForm");
		/* var $username = $("#username");
		var $password = $("#password");
		var $realname = $("#realname");
		var $title = $("#title");
		var $point = $("#point");
		var $mobile = $("#mobile");
		var $company = $("#company");
		var $message = $("#errormsg"); */
		
		$registerForm.validate({
			rules: {
				username: "required",
				pass: {
					required: true,
					pattern: /^[^\s&\"<>]+$/,
					minlength: 4,
					maxlength: 20
				},
				confirmPwd: {
					required: true,
					equalTo: "#password"   // 这里的password是对应元素的id，而不是name
				},
				point: "digits"
			},
			submitHandler: function(){
				console.log("dddd");
				$.ajax({
					url : 'register',
					data : $("#registerForm").serialize(),
					dataType : 'json',
					success : function(r) {
						if (r && r.success) {
							//$.messager.alert('提示', r.msg, 'info'); //easyui中的控件messager
							window.location.href="main";
						} else {
							$.messager.alert('用户注册', r.msg, 'error'); //easyui中的控件messager
						}
					}
				});
			}
		});
		
		register = function(){
			$("registerForm").submit();
		}
		
		$("#point").keydown(onlyNumber);
	});
</script>
</head>
<body>
	<center style="margin-top:30px;">
		<p id="errormsg" style="font-size:15px;color:#FF0000;"></p>
		<form id="registerForm" method="post">
			<table border="0">
				<tr>
					<td style="text-align:right;"><span class="requiredField">*</span>用户名</td>
					<td><input id="username" type="text" name="username" class="myinput"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><span class="requiredField">*</span>密&nbsp;码</td>
					<td><input id="password" type="password" name="pass" class="myinput"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><span class="requiredField">*</span>确认密码</td>
					<td><input id="confirmPwd" type="password" name="confirmPwd" class="myinput"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">真实姓名</td>
					<td><input id="realname" type="text" name="realname" class="myinput"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">职&nbsp;称</td>
					<td><input id="title" type="text" name="title" class="myinput"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><span class="requiredField">*</span>积&nbsp;分</td>
					<td><input id="point" type="text" name="point" class="myinput"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">手&nbsp;机</td>
					<td><input id="mobile" type="text" name="moblie" class="myinput"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">公&nbsp;司</td>
					<td><input id="company" type="text" name="company" class="myinput"/></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<input id="submit" type="submit" onclick="register" value="注册" />
					</td>
				</tr>
			</table>
		</form>
	<center style="margin-top:30px;">
</body>
</html>