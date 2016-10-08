<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%@page import="org.apache.commons.lang.ArrayUtils"%>
<%@page import="com.grain.Setting"%>
<%@page import="com.grain.util.SettingUtils"%>
<%@page import="com.grain.util.SpringUtils"%>
<%@page import="com.grain.Setting.CaptchaType"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><%=SpringUtils.getMessage("admin.login.title")%> - Powered By SHOP++</title>
<meta http-equiv="expires" content="0" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta name="author" content="szy Team" />
<meta name="copyright" content="szy ++" />
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path +"/";
//System.out.println(base);
String captchaId = UUID.randomUUID().toString();
Setting setting = SettingUtils.get();

%>
<link rel="icon" href="<%=base%>favicon.ico" type="image/x-icon" />
<link href="<%=base%>resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=base%>resources/admin/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=base%>resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/easyUI/extJquery.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>

<script type="text/javascript">
	$().ready(function() {
		var $loginForm = $("#loginForm");
		var $username = $("#username");
		var $password = $("#password");
		var $captcha = $("#captcha");
		var $captchaImage = $("#captchaImage");
		var $isRememberUsername = $("#isRememberUsername");
		
		// 更换验证码
		$captchaImage.click( function() {
			$captchaImage.attr("src", "<%=base %>investor/common/captcha?captchaId=<%=captchaId%>&timestamp=" + (new Date()).valueOf());
		});
		
		$loginForm.validate({
			rules: {
				username: {required:true},
				password: {required:true},
				captcha: {required:true}
			},
			submitHandler: function(){
				
				//console.log("kkk" + "${captchaId}");
				if ($isRememberUsername.prop("checked")) {
					addCookie("insectsinvestUsername", $username.val(), {expires: 7 * 24 * 60 * 60});
				} else {
					removeCookie("insectsinvestUsername");
				}
				$.ajax({
					url: 'loginSubmit',
					data: $("#loginForm").serialize(),
					dataType: 'json',
					success: function(r){
						if(r && r.success){
							$("#userRegister").css('display', 'block');
							if(r.msg=='logined'){
								$("#msgCenter").css('display', 'block');
								$("#editPersonalInfo").css('display', 'block');
								$("#logout").css('display', 'block');
								
								parent.$("#farmerCollect").css('display', 'block');
								parent.$("#factoryCollect").css('display', 'block');
								parent.$("#fieldCollect").css('display', 'block');
								parent.$("#depotCollect").css('display', 'block');
								//parent.$("#userRegister").css('display', 'block');
								
								parent.$("#xx4").css('display', 'block');
								parent.$("#xx1").css('display', 'block');
								parent.$("#xx2").css('display', 'block');
								parent.$("#xx3").css('display', 'block');
							}else {
								$("#msgCenter").css('display', 'none');
								$("#editPersonalInfo").css('display', 'none');
								$("#logout").css('display', 'none');
			
								parent.$("#farmerCollect").css('display', 'none');
								parent.$("#factoryCollect").css('display', 'none');
								parent.$("#fieldCollect").css('display', 'none');
								parent.$("#depotCollect").css('display', 'none');
								//parent.$("#userRegister").css('display', 'none');
								
								parent.$("#xx4").css('display', 'none');
								parent.$("#xx1").css('display', 'none');
								parent.$("#xx2").css('display', 'none');
								parent.$("#xx3").css('display', 'none');
							}
							openBlank("<%= request.getContextPath() %>/investor/common/success",{} );
						}else {
							$("#errid").html(r.msg);
						}
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<div class="login">
		<p id="errid">${errormsg}</p>
			<form id="loginForm" method="post">
				<input type="hidden" id="mycaptchaId" name="captchaId" value="<%=captchaId%>" />
				
				<table>
					<tr>
						<td width="190" rowspan="2" align="center" valign="bottom">
							<img src="<%=base%>resources/images/common/logo1.jpg" alt="grainInsects" />
						</td>
						<th>
							<%=SpringUtils.getMessage("admin.login.username")%>:
						</th>
						<td>
							<input type="text" id="username" name="username" class="text" maxlength="20" />
						</td>
					</tr>
					<tr>
						<th>
							<%=SpringUtils.getMessage("admin.login.password")%>:
						</th>
						<td>
							<input type="password" id="password" name="password" class="text" maxlength="20"  />
						</td>
					</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<th>
								<%=SpringUtils.getMessage("admin.captcha.name")%>:
							</th>
							<td>
								<input type="text" id="captcha" name="captcha" class="text captcha" maxlength="4"  />
								<img id="captchaImage" class="captchaImage" src="<%=base %>investor/common/captcha?captchaId=<%=captchaId %>" 
								title="<%=SpringUtils.getMessage("admin.captcha.imageTitle")%>" />
							</td>
						</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<th>
							&nbsp;
						</th>
						<td>
							<label>
								<input type="checkbox" id="isRememberUsername" value="true" />
								<%=SpringUtils.getMessage("admin.login.rememberUsername")%>
							</label>
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<th>
							&nbsp;
						</th>
						<td>
							<input type="button" class="homeButton" value="" onclick="location.href='<%=base%>/'" />
							<input type="submit" class="loginButton" value="<%=SpringUtils.getMessage("admin.login.login")%>" />
							<input type="button" class="registerButton" value="注册" onclick="location.href='<%=base%>investor/common/addInvestorEntrance'" />
						</td>
					</tr>
				</table>
				<div class="powered">COPYRIGHT © 2015-2018 szy.xxx.net ALL RIGHTS RESERVED.</div>
				<div class="link">
					<a href="<%=base%>/"><%=SpringUtils.getMessage("admin.login.home")%></a> |
					<a href="http://www.szy.net"><%=SpringUtils.getMessage("admin.login.official")%></a> |
					<a href="http://bbs.szy.net"><%=SpringUtils.getMessage("admin.login.bbs")%></a> |
					<a href="http://www.szy.net/about.html"><%=SpringUtils.getMessage("admin.login.about")%></a> |
					<a href="http://www.szy.net/contact.html"><%=SpringUtils.getMessage("admin.login.contact")%></a> |
					<a href="http://www.szy.net/license.html"><%=SpringUtils.getMessage("admin.login.license")%></a>
				</div>
				
				
				
				
				<%-- <span><label>用户名</label> <input id="username" name="username" type="text" style="height:25px"/><br/></span>
				<span><label>密&nbsp;码</label> <input id="password" name="password" type="password" style="height:25px"/><br/></span>
				<span>
					<label>验证码</label>
					<input type="text" style="text-transform:uppercase;height:25px" id="captcha" name="captcha" class="text captcha" maxlength="4"  />
					<img id="captchaImage" class="captchaImage" src="<%=base %>investor/common/captcha?captchaId=<%=captchaId %>" 
								title="<%=SpringUtils.getMessage("admin.captcha.imageTitle")%>" /><br/>
				</span>
				<span>
					<label>
						<input type="checkbox" id="isRememberUsername" value="true" />
						<%=SpringUtils.getMessage("admin.login.rememberUsername")%>
					</label>
				</span><br/>
				<span><input id="submit" type="submit" value="登录"  style="text-align:center" /></span> --%>
			</form>
		</div>
		<!-- <div id="footer">
			COPYRIGHT Â© 2015-2018 szy.xxx.net ALL RIGHTS RESERVED.
		</div> -->
</body>
</html>