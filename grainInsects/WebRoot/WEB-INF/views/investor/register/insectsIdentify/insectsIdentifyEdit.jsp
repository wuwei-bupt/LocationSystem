<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- doctype一定要写在这个位置 -->
<%@ include file="/common/taglibs.jsp"%>
<jsp:include page="/common/easyui.jsp"></jsp:include>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	
	 	doEdit = function(){
			$("#inputForm").submit();
		} 
		$(function(){
			var $inputForm = $("#inputForm");
			// 表单验证
			$inputForm.validate({
				rules: {
					sm: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'insectsIdentifyEdit',
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

	<div class="path">路径>>编辑昆虫鉴定信息</div>
	<div class="container" >
		<form id="inputForm"  method="post">
			<input type="hidden" name="sm" value="${sm }"/>
			<table class="input">
				<tr>
					<th><span class="requiredField">*</span>昆虫编码：</th>
					<td>${insectsIdentify.sm }</td>
				</tr>
				<tr>
					<th>虫种：</th>
					<td><input name="kind" class="myinput" type="text" style="width:150px" value="${insectsIdentify.kind }"/></td>
				</tr>
				<tr>
					<th>学名：</th>
					<td><input name="name" class="myinput" type="text" style="width:90px" value="${insectsIdentify.name }"/></td>
				</tr>
				<tr>
					<th>海拔：</th>
					<td><input name="altitude" class="myinput" type="text" style="width:150px" value="${insectsIdentify.altitude }"/>米</td>
				</tr>
				<tr>
					<th>GPS：</th>
					<td>
						GPS(E):<input name="longtitude" class="myinput" type="text" style="width:150px" value="${insectsIdentify.longtitude }"/>、
						GPS(N):<input name="latitude" class="myinput" type="text" style="width:150px" value="${insectsIdentify.latitude }"/>
					</td>
				</tr>
				<tr>
					<th>仓型：</th>
					<td><input name="bintype" class="myinput" type="text" style="width:90px" value="${insectsIdentify.bintype }"/></td>
				</tr>
				<tr>
					<th>粮种-寄主：</th>
					<td><input name="host" class="myinput" type="text" style="width:150px" value="${insectsIdentify.host }"/></td>
				</tr>
				<tr>
					<th>栖息部位：</th>
					<td><input name="habitlocation" class="myinput" type="text" style="width:90px" value="${insectsIdentify.habitlocation }"/></td>
				</tr>
				<tr>
					<th>采集虫态：</th>
					<td><input name="stage" class="myinput" type="text" style="width:150px" value="${insectsIdentify.stage }"/></td>
				</tr>
				<tr>
					<th>采集日期：</th>
					<td>
						<input name="collectdate" class="easyui-datebox" type="text" style="width:90px" value="${insectsIdentify.collectdate }"/>
					</td>
				</tr>
				<tr>
					<th>采集人：</th>
					<td><input name="collector" class="myinput" type="text" style="width:150px" value="${insectsIdentify.collector }"/></td>
				</tr>
				<tr>
					<th>鉴定人：</th>
					<td><input name="identifier" class="myinput" type="text" style="width:150px" value="${insectsIdentify.identifier }"/></td>
				</tr>
				<tr>
					<th>复核人：</th>
					<td><input name="reviewer" class="myinput" type="text" style="width:150px" value="${insectsIdentify.reviewer }"/></td>
				</tr>
				<tr>
					<th>留存地：</th>
					<td><input name="retainplace" class="myinput" type="text" style="width:150px" value="${insectsIdentify.retainplace }"/></td>
				</tr>
				<tr><th>&nbsp;</th>
					<td >
						<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="doEdit()" iconCls="icon-save">修改</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" onclick="goback()" iconCls="icon-back">返回</a>
					</td>
				</tr>	
			</table>		
		</form>
	</div>
</body>
</html>