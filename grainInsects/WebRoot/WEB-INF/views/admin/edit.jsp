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
			<div id="tabs" class="easyui-tabs">
				<div title="修改基本信息" style="padding: 10px">
					<div>
						<span style="width:60px;display:inline-block;">用户名:</span>
						<input type="text" value="${user.username}" readonly="readonly">
					</div>
					
					<div style="margin-top: 10px">
						<span style="width:60px;display:inline-block;">角色:</span>
						<select id="roleIDedit"  "${user.role.name}" style="border: 1px solid #ccc;width: 160px">
							<!-- 供选择的角色 -->
							<c:set value="${roles}" var="roles" />
							<c:choose>
								<c:when test="${fn:length(roles)>=1}">
									<c:forEach var="role" items="${roles}">
									<c:choose>
										<c:when test="${role.name==user.role.name}" >
											<option value='<c:out value="${role.id}"/>' selected='true'>
										</c:when>
										<c:otherwise>
											<option value='<c:out value="${role.id}" />'>
										</c:otherwise>
										</c:choose>
										<c:out value="${role.name}" />
										</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
					</div>
					<div style="margin-top: 10px">
						<span style="width: 60px; display: inline-block;">姓名:</span>
						<input type="text" id="nameedit" name = "nameedit" value="${user.name}"/>
					</div>
					<div style="margin-top: 10px">
						<span style="width: 60px; display: inline-block;">单位:</span>
						<input type="text" id="companyedit" name = "companyedit" value="${user.company}"/>
					</div>
					<div style="margin-top: 10px">
						<span style="width: 60px; display: inline-block;">职称:</span>
						<input type="text" id="titleedit" name = "titleedit" value="${user.title}"/>
					</div>
					<div style="margin-top: 10px">
						<span style="width: 60px; display: inline-block;">手机:</span>
						<input type="text" id="mobileedit" name = "mobileedit" value="${user.mobile}"/>
					</div>				
					
					<div style="margin-top: 30px">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-edit" plain="false" onclick="doroleEdit()">修改</a>
					</div>
				</div>
				
				<div title="修改密码" style="padding: 10px">
					<div>
						<span style="width:60px;display:inline-block;">用户名:</span>
						<input type="text" value="${user.username}" readonly="readonly">
					</div>
					<div style="margin-top: 10px">
						<span style="width:60px;display:inline-block;">新密码:</span>
						<input id="pwedit" type="password" name="passWordedit">
					</div>
					<div style="margin-top: 10px">
						<span style="width:60px;display:inline-block;">确认密码:</span>
						<input id="pwcfmedit" type="password" name="passWordedit">
					</div>
					<div style="margin-top: 30px">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-edit" plain="false" onclick="dopwEdit()">修改</a>
					</div>
				</div>
			</div>

		</div>
	</body>

</html>