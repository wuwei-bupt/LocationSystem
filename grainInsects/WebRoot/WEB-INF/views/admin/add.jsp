<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- doctype一定要写在这个位置 -->
<%@ include file="/common/taglibs.jsp"%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
	</head>
	<body>
		<div class="container" style="text-align: center;">
			<div style="padding: 10px; margin-top: 10px">
				<div>
					<span style="width: 60px; display: inline-block;">用户名:</span>
					<input type="text" id="suName" onblur="checkName(this)">
					<p class="errmsg">
						<img
							src="resources/images/menuIcon/no.png"
							style="vertical-align: baseline" />
						<strong> <span></span> </strong>
					</p>
				</div>
				<!-- 将光标放在用户名输入框 -->
				<script type="text/javascript">
				$("#suName")[0].focus();
				</script>
				<div>
				</div>
				<div style="margin-top: 10px">
					<span style="width: 60px; display: inline-block;">密码:</span>
					<input id="pw" type="password" onblur="checkPw(this)">
					<p class="errmsg">
						<img
							src="resources/images/menuIcon/no.png"
							style="vertical-align: baseline" />
						<strong> <span>密码不能为空</span> </strong>
					</p>
				</div>
				<div style="margin-top: 10px">
					<span style="width: 60px; display: inline-block;">确认密码:</span>
					<input id="pwcfm" type="password" onblur="checkPwcfm(this)">
					<p class="errmsg">
						<img
							src="resources/images/menuIcon/no.png"
							style="vertical-align: baseline" />
						<strong> <span>两次密码不一致</span> </strong>
					</p>
				</div>
				<div style="margin-top: 10px">
					<span style="width: 60px; display: inline-block;">角色:</span>
					<select id="roleID" style="border: 1px solid #ccc; width: 160px">
						<!-- 供选择的角色 -->
						<c:set value="${roles}" var="roles" />
						<c:choose>
							<c:when test="${fn:length(roles)>=1}">
								<c:forEach var="role" items="${roles}">
									<option value='<c:out value="${role.id}"/>'>
										<c:out value="${role.name}" />
									</option>
								</c:forEach>
							</c:when>
						</c:choose>
					</select>
				</div>
				<div style="margin-top: 10px">
					<span style="width: 60px; display: inline-block;">姓名:</span>
					<input type="text" id="name" name = "name"/>
				</div>
				<div style="margin-top: 10px">
					<span style="width: 60px; display: inline-block;">单位:</span>
					<input type="text" id="company" name = "company"/>
				</div>
				<div style="margin-top: 10px">
					<span style="width: 60px; display: inline-block;">职称:</span>
					<input type="text" id="title" name = "title"/>
				</div>
				<div style="margin-top: 10px">
					<span style="width: 60px; display: inline-block;">手机:</span>
					<input type="text" id="mobile" name = "mobile"/>
				</div>				
				<div style="margin-top: 20px">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-edit" plain="false" onclick="doAdd()">提交</a>
				</div>
			</div>
		</div>
	</body>
</html>