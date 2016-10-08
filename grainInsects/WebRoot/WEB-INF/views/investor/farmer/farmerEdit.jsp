<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- doctype一定要写在这个位置 -->
<%@ include file="/common/taglibs.jsp"%>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.print(path);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- <#assign content="welcome"> -->
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
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
	<style type="text/css">
		
		.myinput {
			outline:none;	/*去掉input获得焦点时的外边框*/
			text-align:center;
			border-style:none;
			border-bottom-style:solid;
			border-bottom-width:1px;
			/* background-color:#F2F5F7; */
		}
		table.input {
			width: 100%;
			word-break: break-all;
		}
	</style>
	<script type="text/javascript">
	
		//submit the form
	 	doEdit = function(){
			$("#inputForm").submit();
		} 
		$(function(){
			var $inputForm = $("#inputForm");
			
			// 表单验证
			$inputForm.validate({
				rules: {
					smFarmer: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'farmerEdit',
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
	<div class="path">路径>>编辑农户信息</div>
	<div class="container" >
		<form id="inputForm"  method="post">
			<table class="input">
				<tr>
					<th><span class="requiredField">*</span>农户编号：</th>
					<td><input name="smFarmer" class="myinput" type="text" readonly="readonly" style="width:200px" value="${farmer.smFarmer }"/></td>
				</tr>
				<tr>
					<th>户主姓名：</th>
					<td><input name="nameFamer" class="myinput" type="text" style="width:90px" value="${farmer.nameFamer }"/></td>
				</tr>
				<tr>
					<th>地址：</th>
					<td><input name="address" class="myinput" type="text" style="width:200px" value="${farmer.address }"/></td>
				</tr>
				<tr>
					<th>邮编：</th>
					<td>
						<input name="postcode" class="myinput" type="text" style="width:90px" value="${farmer.postcode }"/>
					</td>
				</tr>
				<tr>
					<th>电话：</th>
					<td>
						<input name="phone" class="myinput" type="text" style="width:90px" value="${farmer.phone }"/>
					</td>
				</tr>
				<tr>
					<th>家庭人口:</th>
					<td>
						<input name="population" class="myinput" type="text" style="width:90px" value="${farmer.population }"/>
					</td>
				</tr>
				<tr>
					<th>经济状况：</th>
					<td>
						<input name="economic" type="radio" <c:if test='${farmer.economic.equals("好") }'> checked="true" </c:if> value="好"/>好
						<input name="economic" type="radio" <c:if test='${farmer.economic.equals("一般") }'> checked="true" </c:if> value="一般"/>一般
						<input name="economic" type="radio" <c:if test='${farmer.economic.equals("差") }'> checked="true" </c:if> value="差"/>差
					</td>
				</tr>
				<tr>
					<th>交通状况:</th>
					<td>
						<input name="traffic" type="radio" <c:if test='${farmer.traffic.equals("好") }'> checked="true" </c:if> value="好"/>好&nbsp;
						<input name="traffic" type="radio" <c:if test='${farmer.traffic.equals("一般") }'> checked="true" </c:if> value="一般"/>一般&nbsp;
						<input name="traffic" type="radio" <c:if test='${farmer.traffic.equals("差") }'> checked="true" </c:if> value="差"/>差
					</td>
				</tr>
				
				<tr>
					<th>地理环境:</th>
					<td>
						<input name="geography" type="radio" <c:if test='${farmer.traffic.equals("平原") }'> checked="true" </c:if> value="平原"/>平原&nbsp;
						<input name="geography" type="radio" <c:if test='${farmer.traffic.equals("滨湖河流地带") }'> checked="true" </c:if> value="滨湖河流地带"/>滨湖河流地带&nbsp;
						<input name="geography" type="radio" <c:if test='${farmer.traffic.equals("山区") }'> checked="true" </c:if> value="山区"/>山区&nbsp;
						<input name="geography" type="radio" <c:if test='${farmer.traffic.equals("山区盆地") }'> checked="true" </c:if> value="山区盆地"/>山区盆地&nbsp;
						<input name="geography" type="radio" <c:if test='${farmer.traffic.equals("丘陵地带") }'> checked="true" </c:if> value="丘陵地带"/>丘陵地带
					</td>
				</tr>
				<tr>
					<th>海拔高度：</th>
					<td>
						<input name="altitude" type="text" class="myinput" style="width:150px;" value="${farmer.altitude }"/>米
					</td>
				</tr>
				<tr>
					<th>GPS:</th>
					<td>GPS(E)<input name="longitude" class="myinput" type="text" style="width:150px" value="${farmer.longitude }"/>、
						GPS(N)<input name="latitude" class="myinput" type="text" style="width:150px" value="${farmer.latitude }"/>
					</td>
				</tr>
				<tr><th>&nbsp;</th>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton"
								plain="false" onclick="doEdit()" iconCls="icon-save">修改</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"
								plain="false" onclick="goback()" iconCls="icon-back">返回</a>
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>