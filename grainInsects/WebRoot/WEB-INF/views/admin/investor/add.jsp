<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- doctype一定要写在这个位置 -->
<%@ include file="/common/taglibs.jsp"%>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<%
	String path = request.getContextPath();
	String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
		<title>main - Powered By Szy++</title>
		<meta name="author" content="Szy++ Team" />
		<meta name="copyright" content="Szy++" />
		<link href="<%=base %>resources/admin/css/common.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="<%=base %>resources/easyUI/themes/cupertino/easyui.css"></link>
		<script type="text/javascript" src="<%=base %>resources/admin/js/common.js"></script>
		<script type="text/javascript" src="<%=base %>resources/admin/js/list.js"></script>
		<script type="text/javascript" src="<%=base %>resources/admin/js/jquery.validate.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
		<script type="text/javascript">
		 	doAdd = function(){
				$("#inputForm").submit();
			}
			$(function(){
				var $inputForm = $("#inputForm");
				// 表单验证
				$inputForm.validate({
					rules: {
						username: {
							required: true,
							remote: {
								url: "check_username",
								cache: false
							}
						},
						point: "required",
						pass: {
							required: true,
							pattern: /^[^\s&\"<>]+$/,
							minlength: 4,
							maxlength: 20
						},
						rePass: {
							required: true,
							equalTo: "#pass"
						},
						hasaudit:	{required:true},
					}, messages: {
						username: {
							required: "必填",
							remote: "用户名已存在"
						}
					},
					submitHandler: function() {
						var formData = new FormData($("#inputForm")[0]); 
						$.ajax({
							url : 'add',
							data: formData,
							dataType : 'json',
							type: 'POST',
							/* async: false,  
					        cache: false,  */
							contentType: false,  
					        processData: false,  
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
			})
			goback = function(){
				window.history.back();
			}
		</script>
		
	</head>
	<body>
		<div class="path">路径>>添加虫调用户</div>
		<div class="container" >
			<form id="inputForm"  method="post">
				<table class="input tabContent">
					<tr>
						<th><span class="requiredField">*</span>用户名：</th>
						<td><input name="username" class="text" type="text"/></td>
					</tr>
					<tr>
						<th>真实姓名：</th>
						<td><input name="realname" class="text" type="text"/></td>
					</tr>
					<tr>
						<th><span class="requiredField">*</span>密码：</th>
						<td><input id="pass" name="pass" class="text" type="password"/></td>
					</tr>
					<tr>
						<th><span class="requiredField">*</span>确认密码：</th>
						<td><input name="rePass" class="text" type="password"/></td>
					</tr>
					<tr>
						<th><span class="requiredField">*</span>积分:</th>
						<td>
							<input name="point" class="text" type="text"/>
						</td>
					</tr>
					<tr>
						<th>职位:</th>
						<td>
							<input name="title" class="text" type="text"/>
						</td>
					</tr>
					<tr>
						<th>单位：</th>
						<td>
							<input name="company" class="text" type="text"/>
						</td>
					</tr>
					<tr>
						<th>手机：</th>
						<td><input name="moblie" class="text" type="text"/></td>
					</tr>
					<tr>
						<th>
							<span class="requiredField">*</span> 审核：
						</th>
						<td>
							<select name="hasaudit" >
								<option value=0 selected="true">否</option>
								<option value=1>是</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<th>&nbsp;</th>
						<td >
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