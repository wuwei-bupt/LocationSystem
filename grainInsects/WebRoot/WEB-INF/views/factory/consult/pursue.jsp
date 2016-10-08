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
	<title>main - Developed by Logan Von</title>
	<meta name="author" content="Logan Von" />
	<meta name="copyright" content="Logan Von" />
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
	 	doAdd = function(){
			$("#inputForm").submit();
		} 
		$(function(){
			
			var $inputForm = $("#inputForm");
			
		
			// 表单验证
			$inputForm.validate({
				rules: {
					//id: "required",
				},
				submitHandler: function() {
					var formData = new FormData($("#inputForm")[0]); 
					$.ajax({
						url : 'pursueConsult',
						data: formData,
						dataType : 'json',
						/* async: false,  
				        cache: false,  */
						contentType: false,  
				        processData: false,  
						success : function(r) {
							if (r && r.success) {
								parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
								window.history.back();
							} else {
								parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
							}
						}
					});
				}
			});
			
			
		})

		goback = function() {
			window.history.back();
		}
	</script>
</head>
<body>			

	<div class="path">路径>>农户咨询追问</div>
	<div class="container" >
		<br/>
		<form id="inputForm"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${id }"/>
			<table class="input">
				<tr>
					<th><span class="requiredField">*</span>主题：</th>
					<td>${title }</td>
				</tr>
				
				<tr>
					<th>类型：</th>
					<td>${typename }</td>
				</tr>
				<tr>
					<th>上次问题及解答：</th>
					<td>
						<table>
							<tr>
								<th>用户提问：</th>
								<td>${describle }</td>
							</tr>
							<tr>
								<th>专家回答：</th>
								<td>${expertadvice }</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th>追问描述：</th>
					<td><textarea id="editor" name="describle" class="editor" style="width: 98%;"></textarea></td>
				</tr>
				<tr>
					<th>咨询专家:</th>
					<td>${expertname }</td>
				</tr>			
			</table>
			
			<table class="input">
				<tr><th>&nbsp;</th>
				<td >
				<!--  <input type="submit" class="button" value="save" /> -->
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